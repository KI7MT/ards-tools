package com.ards.jpa.model;

import java.io.Serializable;
import javax.persistence.*;


/**
 * The persistent class for the sas database table.
 * 
 */
@Entity
@Table(name="sas")
@NamedQuery(name="Sa.findAll", query="SELECT s FROM Sa s")
public class Sa implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@GeneratedValue(strategy=GenerationType.AUTO)
	@Column(unique=true, nullable=false)
	private Integer id;

	@Column(nullable=false, length=80)
	private String name;

	//bi-directional many-to-one association to Pa
	@ManyToOne
	@JoinColumn(name="pas_id", nullable=false)
	private Pa pa;

	public Sa() {
	}

	public Integer getId() {
		return this.id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getName() {
		return this.name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public Pa getPa() {
		return this.pa;
	}

	public void setPa(Pa pa) {
		this.pa = pa;
	}

}