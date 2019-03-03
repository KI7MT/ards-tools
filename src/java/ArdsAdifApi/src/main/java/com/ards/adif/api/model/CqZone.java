package com.ards.adif.api.model;

import java.io.Serializable;
import javax.persistence.*;
import java.util.List;


/**
 * The persistent class for the cq_zone database table.
 * 
 */
@Entity
@Table(name="cq_zone")
@NamedQuery(name="CqZone.findAll", query="SELECT c FROM CqZone c")
public class CqZone implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@Column(unique=true, nullable=false)
	private Integer id;

	@Column(nullable=false)
	private Integer cqzone;

	@Column(nullable=false, length=60)
	private String description;

	//bi-directional many-to-one association to Weblink
	@ManyToOne
	@JoinColumn(name="weblink_id")
	private Weblink weblink;

	//bi-directional many-to-one association to Pas001Cqzone
	@OneToMany(mappedBy="cqZone")
	private List<Pas001Cqzone> pas001Cqzones;

	//bi-directional many-to-one association to Pas015Cqzone
	@OneToMany(mappedBy="cqZone")
	private List<Pas015Cqzone> pas015Cqzones;

	//bi-directional many-to-one association to Pas054
	@OneToMany(mappedBy="cqZone")
	private List<Pas054> pas054s;

	//bi-directional many-to-one association to Pas126
	@OneToMany(mappedBy="cqZone")
	private List<Pas126> pas126s;

	//bi-directional many-to-one association to Pas291Cqzone
	@OneToMany(mappedBy="cqZone")
	private List<Pas291Cqzone> pas291Cqzones;

	public CqZone() {
	}

	public Integer getId() {
		return this.id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public Integer getCqzone() {
		return this.cqzone;
	}

	public void setCqzone(Integer cqzone) {
		this.cqzone = cqzone;
	}

	public String getDescription() {
		return this.description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public Weblink getWeblink() {
		return this.weblink;
	}

	public void setWeblink(Weblink weblink) {
		this.weblink = weblink;
	}

	public List<Pas001Cqzone> getPas001Cqzones() {
		return this.pas001Cqzones;
	}

	public void setPas001Cqzones(List<Pas001Cqzone> pas001Cqzones) {
		this.pas001Cqzones = pas001Cqzones;
	}

	public Pas001Cqzone addPas001Cqzone(Pas001Cqzone pas001Cqzone) {
		getPas001Cqzones().add(pas001Cqzone);
		pas001Cqzone.setCqZone(this);

		return pas001Cqzone;
	}

	public Pas001Cqzone removePas001Cqzone(Pas001Cqzone pas001Cqzone) {
		getPas001Cqzones().remove(pas001Cqzone);
		pas001Cqzone.setCqZone(null);

		return pas001Cqzone;
	}

	public List<Pas015Cqzone> getPas015Cqzones() {
		return this.pas015Cqzones;
	}

	public void setPas015Cqzones(List<Pas015Cqzone> pas015Cqzones) {
		this.pas015Cqzones = pas015Cqzones;
	}

	public Pas015Cqzone addPas015Cqzone(Pas015Cqzone pas015Cqzone) {
		getPas015Cqzones().add(pas015Cqzone);
		pas015Cqzone.setCqZone(this);

		return pas015Cqzone;
	}

	public Pas015Cqzone removePas015Cqzone(Pas015Cqzone pas015Cqzone) {
		getPas015Cqzones().remove(pas015Cqzone);
		pas015Cqzone.setCqZone(null);

		return pas015Cqzone;
	}

	public List<Pas054> getPas054s() {
		return this.pas054s;
	}

	public void setPas054s(List<Pas054> pas054s) {
		this.pas054s = pas054s;
	}

	public Pas054 addPas054(Pas054 pas054) {
		getPas054s().add(pas054);
		pas054.setCqZone(this);

		return pas054;
	}

	public Pas054 removePas054(Pas054 pas054) {
		getPas054s().remove(pas054);
		pas054.setCqZone(null);

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
		pas126.setCqZone(this);

		return pas126;
	}

	public Pas126 removePas126(Pas126 pas126) {
		getPas126s().remove(pas126);
		pas126.setCqZone(null);

		return pas126;
	}

	public List<Pas291Cqzone> getPas291Cqzones() {
		return this.pas291Cqzones;
	}

	public void setPas291Cqzones(List<Pas291Cqzone> pas291Cqzones) {
		this.pas291Cqzones = pas291Cqzones;
	}

	public Pas291Cqzone addPas291Cqzone(Pas291Cqzone pas291Cqzone) {
		getPas291Cqzones().add(pas291Cqzone);
		pas291Cqzone.setCqZone(this);

		return pas291Cqzone;
	}

	public Pas291Cqzone removePas291Cqzone(Pas291Cqzone pas291Cqzone) {
		getPas291Cqzones().remove(pas291Cqzone);
		pas291Cqzone.setCqZone(null);

		return pas291Cqzone;
	}

}