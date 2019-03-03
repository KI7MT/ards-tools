package com.ards.adif.api.model;

import java.io.Serializable;
import javax.persistence.*;
import java.util.Date;


/**
 * The persistent class for the rdxc_district database table.
 * 
 */
@Entity
@Table(name="rdxc_district")
@NamedQuery(name="RdxcDistrict.findAll", query="SELECT r FROM RdxcDistrict r")
public class RdxcDistrict implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@Column(unique=true, nullable=false)
	private Integer id;

	@Column(nullable=false, length=5)
	private String code;

	@Column(length=120)
	private String district;

	@Column(name="has_replacement", nullable=false)
	private Boolean hasReplacement;

	@Column(name="is_deleted", nullable=false)
	private Boolean isDeleted;

	@Column(name="is_new_rda", nullable=false)
	private Boolean isNewRda;

	@Column(name="migration_district", length=5)
	private String migrationDistrict;

	@Temporal(TemporalType.DATE)
	@Column(name="valid_since")
	private Date validSince;

	//bi-directional many-to-one association to Rdxc
	@ManyToOne
	@JoinColumn(name="rdxc_id", nullable=false)
	private Rdxc rdxc;

	public RdxcDistrict() {
	}

	public Integer getId() {
		return this.id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getCode() {
		return this.code;
	}

	public void setCode(String code) {
		this.code = code;
	}

	public String getDistrict() {
		return this.district;
	}

	public void setDistrict(String district) {
		this.district = district;
	}

	public Boolean getHasReplacement() {
		return this.hasReplacement;
	}

	public void setHasReplacement(Boolean hasReplacement) {
		this.hasReplacement = hasReplacement;
	}

	public Boolean getIsDeleted() {
		return this.isDeleted;
	}

	public void setIsDeleted(Boolean isDeleted) {
		this.isDeleted = isDeleted;
	}

	public Boolean getIsNewRda() {
		return this.isNewRda;
	}

	public void setIsNewRda(Boolean isNewRda) {
		this.isNewRda = isNewRda;
	}

	public String getMigrationDistrict() {
		return this.migrationDistrict;
	}

	public void setMigrationDistrict(String migrationDistrict) {
		this.migrationDistrict = migrationDistrict;
	}

	public Date getValidSince() {
		return this.validSince;
	}

	public void setValidSince(Date validSince) {
		this.validSince = validSince;
	}

	public Rdxc getRdxc() {
		return this.rdxc;
	}

	public void setRdxc(Rdxc rdxc) {
		this.rdxc = rdxc;
	}

}