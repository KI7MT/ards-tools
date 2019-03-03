package com.ards.adif.api.model;

import java.io.Serializable;
import javax.persistence.*;
import java.util.List;


/**
 * The persistent class for the rdxc database table.
 * 
 */
@Entity
@Table(name="rdxc")
@NamedQuery(name="Rdxc.findAll", query="SELECT r FROM Rdxc r")
public class Rdxc implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@Column(unique=true, nullable=false)
	private Integer id;

	@Column(name="is_deleted", nullable=false)
	private Boolean isDeleted;

	@Column(nullable=false, length=60)
	private String oblast;

	@Column(nullable=false, length=4)
	private String prefix;

	@Column(name="rdxc_code", nullable=false, length=2)
	private String rdxcCode;

	//bi-directional many-to-one association to RdxcDistrict
	@OneToMany(mappedBy="rdxc")
	private List<RdxcDistrict> rdxcDistricts;

	public Rdxc() {
	}

	public Integer getId() {
		return this.id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public Boolean getIsDeleted() {
		return this.isDeleted;
	}

	public void setIsDeleted(Boolean isDeleted) {
		this.isDeleted = isDeleted;
	}

	public String getOblast() {
		return this.oblast;
	}

	public void setOblast(String oblast) {
		this.oblast = oblast;
	}

	public String getPrefix() {
		return this.prefix;
	}

	public void setPrefix(String prefix) {
		this.prefix = prefix;
	}

	public String getRdxcCode() {
		return this.rdxcCode;
	}

	public void setRdxcCode(String rdxcCode) {
		this.rdxcCode = rdxcCode;
	}

	public List<RdxcDistrict> getRdxcDistricts() {
		return this.rdxcDistricts;
	}

	public void setRdxcDistricts(List<RdxcDistrict> rdxcDistricts) {
		this.rdxcDistricts = rdxcDistricts;
	}

	public RdxcDistrict addRdxcDistrict(RdxcDistrict rdxcDistrict) {
		getRdxcDistricts().add(rdxcDistrict);
		rdxcDistrict.setRdxc(this);

		return rdxcDistrict;
	}

	public RdxcDistrict removeRdxcDistrict(RdxcDistrict rdxcDistrict) {
		getRdxcDistricts().remove(rdxcDistrict);
		rdxcDistrict.setRdxc(null);

		return rdxcDistrict;
	}

}