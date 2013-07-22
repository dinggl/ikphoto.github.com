package com.baidu.action;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts2.ServletActionContext;
import org.apache.struts2.interceptor.ServletResponseAware;

import com.baidu.scan.model.Cache;
import com.baidu.scan.model.Folder;
import com.baidu.scan.model.Photo;
import com.baidu.scan.service.FolderService;
import com.baidu.util.UUID;
import com.baidu.util.Util;
import com.google.gson.reflect.TypeToken;
import com.opensymphony.xwork2.ActionSupport;

public class FolderAction extends ActionSupport implements ServletResponseAware {
	private HttpServletResponse servletResponse;

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	public FolderAction() {
		// TODO Auto-generated constructor stub
	}

	private FolderService folderService;

	public FolderService getFolderService() {
		return folderService;
	}

	@Resource(name = "folderService")
	public void setFolderService(FolderService folderService) {
		this.folderService = folderService;
	}

	public void createNewFolder() {
		Folder folder = folderService.createNewFolder();
		response(Util.Entity2Json(folder));
	}

	public void response(String response) {
		ServletActionContext.getResponse().setContentType(
				"text/json;charset=UTF-8");
		try {
			ServletActionContext.getResponse().getWriter().write(response);
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	private int folderid = -1;
	private String newName;

	public int getFolderid() {
		return folderid;
	}

	public void setFolderid(int folderid) {
		this.folderid = folderid;
	}

	public String getNewName() {
		return newName;
	}

	public void setNewName(String newName) {
		this.newName = newName;
	}

	public void updateFolderName() {

		Folder folder = this.folderService.updateFolderName(folderid, newName);
		folder.setPhotos(null);
		folder.setFengmian(null);
		response(Util.Entity2Json(folder));
	}

	public String getImageFileName() {
		return imageFileName;
	}

	public void setImageFileName(String imageFileName) {
		this.imageFileName = imageFileName;
	}

	public String getImageContentType() {
		return imageContentType;
	}

	public void setImageContentType(String imageContentType) {
		this.imageContentType = imageContentType;
	}

	private File image;
	private String imageFileName;
	private String imageContentType;

	public File getImage() {
		return image;
	}

	public void setImage(File image) {
		this.image = image;
	}

	private String uuid;

	public String getUuid() {
		return uuid;
	}

	public void setUuid(String uuid) {
		this.uuid = uuid;
	}

	public String upload() {
		if (image != null) {
			File basePath = new File(ServletActionContext.getServletContext()
					.getRealPath("cache"));
			if (!basePath.exists()) {
				basePath.mkdirs();
			}
			uuid = UUID.getUUID() + "_"
					+ imageFileName.substring(imageFileName.lastIndexOf("."));
			File cache = new File(basePath.getAbsolutePath() + File.separator
					+ uuid);
			if (cache.exists()) {
				cache.delete();
			}
			image.renameTo(cache);
		}
		return "upload";
	}

	private List<Folder> folders;

	public String folders() {
		folders = folderService.listFolders();
		return "folders";
	}

	private List<String> marks;

	public List<String> getMarks() {
		return marks;
	}

	public void setMarks(List<String> marks) {
		this.marks = marks;
	}

	public String photo() {
		folders = folderService.listFullFolders();
		List<Photo> temp = folderService.listMarks();
		List<String> filter = new ArrayList<String>();
		for (Photo photo : temp) {
			if (!filter.contains(photo.getDescription())) {
				filter.add(photo.getDescription());
			}
		}
		marks = filter;
		return "photo";
	}

	private String search;

	public String getSearch() {
		return search;
	}

	private String photoname;

	public String getPhotoname() {
		return photoname;
	}

	public void setPhotoname(String photoname) {
		this.photoname = photoname;
	}

	public void download() {
		this.servletResponse.setContentType("application/octet-stream");
		this.servletResponse.addHeader("Content-Disposition",
				new StringBuilder("attachment;filename=").append(photoname)
						.toString());
		try {
			OutputStream out = this.servletResponse.getOutputStream();
			File basePath = new File(ServletActionContext.getServletContext()
					.getRealPath("xiaoming"));
			File file = new File(basePath.getAbsolutePath() + File.separator
					+ photoname);
			FileInputStream fi = new FileInputStream(file);
			byte buffer[] = new byte[4096];
			int read;
			while ((read = fi.read(buffer)) != -1) {
				out.write(buffer, 0, read);
			}
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	public void setSearch(String search) {
		this.search = search;
	}

	public void listPhotos() throws UnsupportedEncodingException {
		List<Photo> list = null;
		if (folderid != -1) {
			list = folderService.listPhotos(folderid);
		} else if (search != null) {
			search = URLDecoder.decode(search, "UTF-8");
			System.out.println("listphotos" + search);
			list = folderService.listPhotos(search);
		}
		if (list != null) {
			for (Photo photo : list) {
				photo.setFolder(null);
			}
		}
		this.response(Util.Entity2Json(list));
	}

	private String newMark;
	private int photoid;

	public String getNewMark() {
		return newMark;
	}

	public void setNewMark(String newMark) {
		this.newMark = newMark;
	}

	public int getPhotoid() {
		return photoid;
	}

	public void updatePhotoMark() {
		Photo photo = this.folderService.updatePhotoMark(photoid, newMark);
		photo.setFolder(null);
		this.response(Util.Entity2Json(photo));
	}

	public void setPhotoid(int photoid) {
		this.photoid = photoid;
	}

	public void listFolders() {
		List<Folder> list = folderService.listFolders();
		for (Folder folder : list) {
			folder.setPhotos(null);
			folder.setFengmian(null);
		}
		this.response(Util.Entity2Json(list));
	}

	public List<Folder> getFolders() {
		return folders;
	}

	public void setFolders(List<Folder> folders) {
		this.folders = folders;
	}

	private String jsonString;

	public String getJsonString() {
		return jsonString;
	}

	public void setJsonString(String jsonString) {
		this.jsonString = jsonString;
	}

	public void saveImages() {
		List<Cache> list = Util.gson.fromJson(jsonString,
				new TypeToken<List<Cache>>() {
				}.getType());
		this.folderService.saveImages(list, folderid);
		response("{'msg':'ok'}");
	}

	@Override
	public void setServletResponse(HttpServletResponse servletResponse) {
		// TODO Auto-generated method stub
		this.servletResponse = servletResponse;
	}

}
