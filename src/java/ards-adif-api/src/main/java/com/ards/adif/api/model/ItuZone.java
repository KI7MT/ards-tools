package com.ards.adif.api.model;

import java.io.Serializable;
import javax.persistence.*;
import java.util.List;


/**
 * The persistent class for the itu_zone database table.
 * 
 */
@Entity
@Table(name="itu_zone")
@NamedQuery(name="ItuZone.findAll", query="SELECT i FROM ItuZone i")
public class ItuZone implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@Column(unique=true, nullable=false)
	private Integer id;

	@Column(length=300)
	private String description;

	@Column(nullable=false)
	private Integer ituzone;

	//bi-directional many-to-one association to Weblink
	@ManyToOne
	@JoinColumn(name="weblink_id")
	private Weblink weblink;

	//bi-directional many-to-one association to Pas001Ituzone
	@OneToMany(mappedBy="ituZone")
	private List<Pas001Ituzone> pas001Ituzones;

	//bi-directional many-to-one association to Pas015Ituzone
	@OneToMany(mappedBy="ituZone")
	private List<Pas015Ituzone> pas015Ituzones;

	//bi-directional many-to-one association to Pas054
	@OneToMany(mappedBy="ituZone")
	private List<Pas054> pas054s;

	//bi-directional many-to-one association to Pas126
	@OneToMany(mappedBy="ituZone")
	private List<Pas126> pas126s;

	//bi-directional many-to-one association to Pas291Ituzone
	@OneToMany(mappedBy="ituZone")
	private List<Pas291Ituzone> pas291Ituzones;

	public ItuZone() {
	}

	public Integer getId() {
		return this.id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getDescription() {
		return this.description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public Integer getItuzone() {
		return this.ituzone;
	}

	public void setItuzone(Integer ituzone) {
		this.ituzone = ituzone;
	}

	public Weblink getWeblink() {
		return this.weblink;
	}

	public void setWeblink(Weblink weblink) {
		this.weblink = weblink;
	}

	public List<Pas001Ituzone> getPas001Ituzones() {
		return this.pas001Ituzones;
	}

	public void setPas001Ituzones(List<Pas001Ituzone> pas001Ituzones) {
		this.pas001Ituzones = pas001Ituzones;
	}

	public Pas001Ituzone addPas001Ituzone(Pas001Ituzone pas001Ituzone) {
		getPas001Ituzones().add(pas001Ituzone);
		pas001Ituzone.setItuZone(this);

		return pas001Ituzone;
	}

	public Pas001Ituzone removePas001Ituzone(Pas001Ituzone pas001Ituzone) {
		getPas001Ituzones().remove(pas001Ituzone);
		pas001Ituzone.setItuZone(null);

		return pas001Ituzone;
	}

	public List<Pas015Ituzone> getPas015Ituzones() {
		return this.pas015Ituzones;
	}

	public void setPas015Ituzones(List<Pas015Ituzone> pas015Ituzones) {
		this.pas015Ituzones = pas015Ituzones;
	}

	public Pas015Ituzone addPas015Ituzone(Pas015Ituzone pas015Ituzone) {
		getPas015Ituzones().add(pas015Ituzone);
		pas015Ituzone.setItuZone(this);

		return pas015Ituzone;
	}

	public Pas015Ituzone removePas015Ituzone(Pas015Ituzone pas015Ituzone) {
		getPas015Ituzones().remove(pas015Ituzone);
		pas015Ituzone.setItuZone(null);

		return pas015Ituzone;
	}

	public List<Pas054> getPas054s() {
		return this.pas054s;
	}

	public void setPas054s(List<Pas054> pas054s) {
		this.pas054s = pas054s;
	}

	public Pas054 addPas054(Pas054 pas054) {
		getPas054s().add(pas054);
		pas054.setItuZone(this);

		return pas054;
	}

	public Pas054 removePas054(Pas054 pas054) {
		getPas054s().remove(pas054);
		pas054.setItuZone(null);

		return pas054;
	}

	public List<Pas126> getPas126s() {
		return this.pas126s;
	}

	public void setPas126s(List<Pas126> pas126s) {
		this.pas126s = pas126s;
	}

	public Pas126 addPas126(Pas126 pas126) {
		getPas126s().add(pas126);
		pas126.setItuZone(this);

		return pas126;
	}

	public Pas126 removePas126(Pas126 pas126) {
		getPas126s().remove(pas126);
		pas126.setItuZone(null);

		return pas126;
	}

	public List<Pas291Ituzone> getPas291Ituzones() {
		return this.pas291Ituzones;
	}

	public void setPas291Ituzones(List<Pas291Ituzone> pas291Ituzones) {
		this.pas291Ituzones = pas291Ituzones;
	}

	public Pas291Ituzone addPas291Ituzone(Pas291Ituzone pas291Ituzone) {
		getPas291Ituzones().add(pas291Ituzone);
		pas291Ituzone.setItuZone(this);

		return pas291Ituzone;
	}

	public Pas291Ituzone removePas291Ituzone(Pas291Ituzone pas291Ituzone) {
		getPas291Ituzones().remove(pas291Ituzone);
		pas291Ituzone.setItuZone(null);

		return pas291Ituzone;
	}

}