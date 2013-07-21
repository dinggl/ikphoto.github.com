package com.baidu.scan.service;

import java.awt.image.BufferedImage;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.util.Date;
import java.util.List;

import javax.annotation.Resource;
import javax.imageio.ImageIO;

import org.apache.struts2.ServletActionContext;
import org.springframework.stereotype.Component;

import com.baidu.scan.dao.FolderDao;
import com.baidu.scan.model.Cache;
import com.baidu.scan.model.Folder;
import com.baidu.scan.model.Photo;
import com.baidu.util.Util;

@Component("folderService")
public class FolderService {
	private FolderDao folderDao;

	public FolderDao getFolderDao() {
		return folderDao;
	}

	@Resource(name="folderDao")
	public void setFolderDao(FolderDao folderDao) {
		this.folderDao = folderDao;
	}

	public Folder createNewFolder() {
		// TODO Auto-generated method stub
		return this.folderDao.createNewFolder(Util.parseDate2Name(new Date()));
	}

	public List<Folder> listFolders() {
		// TODO Auto-generated method stub
		return this.folderDao.listFolders();
	}

	public Folder updateFolderName(int folderid, String newName) {
		// TODO Auto-generated method stub
		return this.folderDao.updateFolderName(folderid,newName);
	}

	public void saveImages(List<Cache> list, int folderid) {
		// TODO Auto-generated method stub
		Folder folder = this.folderDao.getFolder(folderid);
		File basePath = new File(ServletActionContext.getServletContext().getRealPath("cache"));
    	if(!basePath.exists()){  
             basePath.mkdirs();  
        } 
    	File filePath = new File(ServletActionContext.getServletContext().getRealPath("xiaoming"));
    	if(!filePath.exists()){  
            filePath.mkdirs();  
       } 
    	//List<Photo> photos = new ArrayList<Photo>();
    	Photo first = null;
		for(Cache cache : list)
		{
			Photo photo = new Photo();
			photo.setFolder(folder);
			photo.setDescription(cache.getMark());
			
		    folderDao.save(photo);
		    if(first==null)
		    	first = photo;
		    photo.setName(photo.getId()+cache.getType());
		    
	    	File cachefile = new File(basePath.getAbsolutePath()+File.separator+cache.getUuid());
	    	File destfile = new File(filePath.getAbsolutePath()+File.separator+photo.getName());
	    	cachefile.renameTo(destfile);
	        
	        BufferedImage sourceImg = null;
			try {
				sourceImg = ImageIO.read(new FileInputStream(destfile));
			} catch (FileNotFoundException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}   
			if(sourceImg!=null)
	        photo.setSize(sourceImg.getWidth()+"*"+sourceImg.getHeight());
	    	cachefile.delete();
	    	folderDao.update(photo);
	    	if(cache.isRadio())
	    	{
	    		folder.setFengmian(photo);
	    	}
		}
		if(folder.getFengmian()==null)
			folder.setFengmian(first);
		folder.setSize(folder.getSize()+list.size());
		folderDao.update(folder);
	}

	public List<Photo> listPhotos(int folderid) {
		// TODO Auto-generated method stub
		return folderDao.listPhotos(folderid);
	}

	public List<Folder> listFullFolders() {
		// TODO Auto-generated method stub
		return folderDao.listFullFolders();
	}

	public List<Photo> listMarks() { 
		// TODO Auto-generated method stub
		return folderDao.listMarks();
		
	}

	public List<Photo> listPhotos(String search) {
		// TODO Auto-generated method stub
		return folderDao.listPhotos(search);
	}

	public Photo updatePhotoMark(int photoid, String newMark) {
		// TODO Auto-generated method stub
		return this.folderDao.updatePhotoMark(photoid, newMark);
	}

}
