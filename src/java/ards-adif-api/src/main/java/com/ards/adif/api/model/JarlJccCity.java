package com.ards.adif.api.model;

import java.io.Serializable;
import javax.persistence.*;
import java.util.Date;


/**
 * The persistent class for the jarl_jcc_city database table.
 * 
 */
@Entity
@Table(name="jarl_jcc_city")
@NamedQuery(name="JarlJccCity.findAll", query="SELECT j FROM JarlJccCity j")
public class JarlJccCity implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@Column(unique=true, nullable=false)
	private Integer id;

	@Column(length=30)
	private String city;

	@Temporal(TemporalType.DATE)
	@Column(name="deleted_date")
	private Date deletedDate;

	@Column(name="is_deleted", nullable=false)
	private Boolean isDeleted;

	@Column(length=6)
	private String number;

	//bi-directional many-to-one association to JarlJcc
	@ManyToOne
	@JoinColumn(name="jcc_id", nullable=false)
	private JarlJcc jarlJcc;

	public JarlJccCity() {
	}

	public Integer getId() {
		return this.id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getCity() {
		return this.city;
	}

	public void setCity(String city) {
		this.city = city;
	}

	public Date getDeletedDate() {
		return this.deletedDate;
	}

	public void setDeletedDate(Date deletedDate) {
		this.deletedDate = deletedDate;
	}

	public Boolean getIsDeleted() {
		return this.isDeleted;
	}

	public void setIsDeleted(Boolean isDeleted) {
		this.isDeleted = isDeleted;
	}

	public String getNumber() {
		return this.number;
	}

	public void setNumber(String number) {
		this.number = number;
	}

	public JarlJcc getJarlJcc() {
		return this.jarlJcc;
	}

	public void setJarlJcc(JarlJcc jarlJcc) {
		this.jarlJcc = jarlJcc;
	}

}