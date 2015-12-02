/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
//package se.kth.bbc.fileoperations;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.io.RandomAccessFile;
import java.io.StringReader;
import java.nio.ByteBuffer;
import java.nio.channels.FileChannel;
import java.nio.file.Paths;
import java.util.HashMap;
import java.util.LinkedList;
import java.util.Map;
import java.util.Properties;
import java.util.logging.Level;
import java.util.logging.Logger;


/**
 * Provides an interface to interact with Charon
 *
 * @author tiago
 */
public class CharonOperations {


	private static String CHARON_PATH = "/srv/Charon";
	private static String charonMountPointPath = "/srv/Charon/charon_fs";
	private static String addNewGranteePath = CHARON_PATH + File.separator + "NewSiteIds";
	private static String addNewSNSPath = CHARON_PATH + File.separator + "NewSNSs";
	private static String addedGrantees = CHARON_PATH + File.separator + "config/addedGrantees";
	private static String my_site_id = CHARON_PATH + File.separator + "config/site-id.charon";

	public static void setCharonMountPointPath(String path){
		charonMountPointPath = path;
	}

	public static void setCharonInstallPath(String path){
		CHARON_PATH = path;
		addNewGranteePath = CHARON_PATH + File.separator + "NewSiteIds";
		addNewSNSPath = CHARON_PATH + File.separator + "NewSNSs";
		addedGrantees = CHARON_PATH + File.separator + "config/addedGrantees";
		my_site_id = CHARON_PATH + File.separator + "config/site-id.charon";
	}

	public static void addSiteId(String site_id){
		String site_id_filename = "site-id.charon";
		File siteIdFile_temp = new File(CHARON_PATH + File.separator + site_id_filename);
		try {
			if(!siteIdFile_temp.exists())
				siteIdFile_temp.createNewFile();

			FileOutputStream out = new FileOutputStream(siteIdFile_temp);
			out.write(site_id.getBytes());
			out.close();

			siteIdFile_temp.renameTo(new File(addNewGranteePath + File.separator + site_id_filename));
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	public static void removeSiteId(int granteeId){
		File grantees = new File(addedGrantees);
		File temp = new File(addedGrantees+"_");
		FileInputStream fis;
		FileOutputStream fos;
		try {
			fis = new FileInputStream(grantees);
			fos = new FileOutputStream(temp);
			BufferedReader br = new BufferedReader(new InputStreamReader(fis));
			BufferedWriter bw = new BufferedWriter(new OutputStreamWriter(fos));
			String line = null;
			while ((line = br.readLine()) != null){
				if(line.length() > 0){
					int lineId = Integer.parseInt(line.substring(line.indexOf("(")+1, line.indexOf(")")));
					if(lineId != granteeId){
						bw.write(line);
						bw.newLine();
					}
				}
			}
			temp.renameTo(new File(addedGrantees));
			br.close();
			bw.close();
			fis.close();
			fos.close();
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	public static String listSiteIds(){
		File grantees = new File(addedGrantees);
		FileInputStream fis;
		try {
			fis = new FileInputStream(grantees);
			BufferedReader br = new BufferedReader(new InputStreamReader(fis));
			String line = null;
			String toRet = "";
			while ((line = br.readLine()) != null){
				if(!line.startsWith("#"))
					toRet += line+"\n";
			}
			br.close();
			fis.close();
			return toRet;
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
		return null;
	}

	public static String getMySiteId(){
		File site_id = new File(my_site_id);
		FileInputStream fis;
		try {
			fis = new FileInputStream(site_id);
			BufferedReader br = new BufferedReader(new InputStreamReader(fis));
			String line = null;
			String toRet = "";
			while ((line = br.readLine()) != null){
				if(!line.startsWith("#"))
					toRet += line+"\n";
			}
			br.close();
			return toRet;
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
		return null;
	}

	public static String createSharedRepository(int granteeId, String repPath, String permissions){

		if(!mkdir(repPath, null))
			return "ERROR: cannot create the folder or the folder is no empty!";
		return share(repPath, permissions, granteeId);
	}

	/**
	 * Creates a directory
	 *
	 * @param path - The path to the new folder
	 * @param location - the location where the files inside that path will be placed (null represents the cloud-of-clouds)
	 * @return - true if the folder is created successfully (or if the folder already exists), false otherwise
	 */
	public static boolean mkdir(String path, String location){

		if(!path.startsWith("/"))
			path = File.separator+path;
		File file = null;
		if(location == null)
			file = new File(charonMountPointPath + path);
		else{
			file = new File(charonMountPointPath+File.separator+".site="+location+path);
		}
		int count = 0;
		if(file.exists()){
			if(file.list().length == 0)
				return true;
			else
				return false;
		}
		while(!file.exists() && count < 3) {
			boolean flag = file.mkdir();
			if(flag)
				return true;
			else
				count ++;
		}
		return false;
	}

	/**
	 * Share a folder with other users
	 *
	 * @param path - the path to the folder (the folder should be empty)
	 * @param permissions - the desired permissions ('rxw' to read and write)
	 * @param granteId - the id of the grantee user
	 * @return - true if the folder is successfully shared, false otherwise
	 */
	public static String share(String path, String permissions, int granteeId){

		if(!path.startsWith("/"))
			path = File.separator+path;

		try {
			String ACLcommand = "setfacl -m u:"+granteeId+":"+permissions+" "+charonMountPointPath+path;
			//Process p = Runtime.getRuntime().exec(new String[]{"bash","-c",ACLcommand});
			Process p = Runtime.getRuntime().exec(ACLcommand);
			p.waitFor();

			File file = new File(CHARON_PATH);
			byte[] data = null;
			for(File f : file.listFiles()){
				if(f.getName().startsWith("share")){
					RandomAccessFile rd = new RandomAccessFile(f, "rw");
					data = new byte[(int)f.length()];
					rd.read(data);

					f.delete();
					if(data!=null){
					}
				}
			}
			return new String(data);

		} catch (IOException e) {
			e.printStackTrace();
		} catch (InterruptedException e) {
			e.printStackTrace();
		}
		return null;
	}

	public static boolean addSharedRepository(String token){

		File tokenFile_temp = new File(CHARON_PATH + File.separator + "token.share");
		try {
			if(!tokenFile_temp.exists())
				tokenFile_temp.createNewFile();

			FileOutputStream out = new FileOutputStream(tokenFile_temp);
			out.write(token.getBytes());
			out.close();
			tokenFile_temp.renameTo(new File(addNewSNSPath + File.separator + "token.share"));
			return true;
		} catch (IOException e) {
			e.printStackTrace();
		}
		return false;
	}

	public static void clean(String path){

		if(!path.startsWith("/"))
			path = File.separator+path;

		String RMcommand = "rm -rf " + charonMountPointPath+path;
		//Process p = Runtime.getRuntime().exec(new String[]{"bash","-c",ACLcommand});
		Process p;
		try {
			p = Runtime.getRuntime().exec(RMcommand);
			p.waitFor();
		} catch (IOException e) {
			e.printStackTrace();
		} catch (InterruptedException e) {
			e.printStackTrace();
		}
	}
}
