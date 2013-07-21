package com.baidu.scan.model;

import javax.persistence.*;
import java.util.List;

/**
 * Created with IntelliJ IDEA.
 * User: dingye
 * Date: 13-7-18
 * Time: ����12:13
 * To change this template use File | Settings | File Templates.
 */

@Entity
@Table(name="t_folder")
public class Folder {
    private int id;
    private String name;
    private int size;
    private boolean shared;
    private List<Photo> photos;
    private Photo fengmian;

    @OneToOne(fetch=FetchType.EAGER)
    @JoinColumn(name="fengmian")
    public Photo getFengmian() {
		return fengmian;
	}

	public void setFengmian(Photo fengmian) {
		this.fengmian = fengmian;
	}

	@OneToMany(mappedBy = "folder")
    public List<Photo> getPhotos() {
        return photos;
    }

    public void setPhotos(List<Photo> photos) {
        this.photos = photos;
    }

    @Id
    @GeneratedValue
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public int getSize() {
        return size;
    }

    public void setSize(int size) {
        this.size = size;
    }

    public boolean isShared() {
        return shared;
    }

    public void setShared(boolean shared) {
        this.shared = shared;
    }
}
