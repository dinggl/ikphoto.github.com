package com.baidu.scan.dao;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.orm.hibernate3.HibernateTemplate;
import org.springframework.stereotype.Component;

import com.baidu.scan.model.Folder;
import com.baidu.scan.model.Photo;

@Component("folderDao")
public class FolderDao {
	private HibernateTemplate hibernateTemplate;

	public HibernateTemplate getHibernateTemplate() {
		return hibernateTemplate;
	}

	@Resource
	public void setHibernateTemplate(HibernateTemplate hibernateTemplate) {
		this.hibernateTemplate = hibernateTemplate;
	}

	public Folder createNewFolder(String name) {
		// TODO Auto-generated method stub
		Folder folder = new Folder();
		folder.setName(name);
		folder.setSize(0);
		this.hibernateTemplate.save(folder);
		return folder;
	}

	@SuppressWarnings("unchecked")
	public List<Folder> listFolders() {
		// TODO Auto-generated method stub
		return (List<Folder>) this.hibernateTemplate.find("from Folder");
	}

	public Folder updateFolderName(int folderid, String newName) {
		// TODO Auto-generated method stub
		Folder folder = (Folder) this.hibernateTemplate.get(Folder.class,
				folderid);
		folder.setName(newName);
		this.hibernateTemplate.update(folder);
		return folder;
	}

	public Folder getFolder(int folderid) {
		// TODO Auto-generated method stub
		return (Folder) this.hibernateTemplate.get(Folder.class, folderid);
	}

	public void save(Photo photo) {
		// TODO Auto-generated method stub
		this.hibernateTemplate.save(photo);
	}

	public void update(Photo photo) {
		// TODO Auto-generated method stub
		this.hibernateTemplate.update(photo);
	}

	public void update(Folder folder) {
		// TODO Auto-generated method stub
		this.hibernateTemplate.update(folder);
	}

	@SuppressWarnings("unchecked")
	public List<Photo> listPhotos(int folderid) {
		// TODO Auto-generated method stub
		return (List<Photo>) this.hibernateTemplate
				.find("from Photo where folder.id = " + folderid);
	}

	@SuppressWarnings("unchecked")
	public List<Folder> listFullFolders() {
		// TODO Auto-generated method stub
		return (List<Folder>) (this.hibernateTemplate
				.find("from Folder where size > 0"));
	}

	@SuppressWarnings("unchecked")
	public List<Photo> listMarks() {
		// TODO Auto-generated method stub
		return (List<Photo>) (this.hibernateTemplate
				.find("from Photo where description !='' "));
	}

	@SuppressWarnings("unchecked")
	public List<Photo> listPhotos(String search) {
		// TODO Auto-generated method stub
		if (search.equals("null"))
			return (List<Photo>) this.hibernateTemplate.find("from Photo");
		return (List<Photo>) this.hibernateTemplate
				.find("from Photo where  description like '%" + search + "%'");
	}

	public Photo updatePhotoMark(int photoid, String newMark) {
		// TODO Auto-generated method stub
		Photo photo = (Photo) this.hibernateTemplate.get(Photo.class, photoid);
		photo.setDescription(newMark);
		this.hibernateTemplate.update(photo);
		return photo;
	}

}
