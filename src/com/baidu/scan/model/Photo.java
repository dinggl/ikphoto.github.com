package com.baidu.scan.model;

import javax.persistence.*;

/**
 * Created with IntelliJ IDEA.
 * User: dingye
 * Date: 13-7-18
 * Time: ����10:16
 * To change this template use File | Settings | File Templates.
 */
@Entity
@Table(name="t_photo")
public class Photo {
    @Id
    @GeneratedValue
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public String getSize() {
        return size;
    }

    @ManyToOne
    public Folder getFolder() {
        return folder;
    }

    public void setFolder(Folder folder) {
        this.folder = folder;
    }

    public void setSize(String size) {
        this.size = size;

    }

    private int id;
    private String description;
    private String size;
    private String name;
    public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	private Folder folder;
    private int downloadCount;
	public int getDownloadCount() {
		return downloadCount;
	}

	public void setDownloadCount(int downloadCount) {
		this.downloadCount = downloadCount;
	}
}
