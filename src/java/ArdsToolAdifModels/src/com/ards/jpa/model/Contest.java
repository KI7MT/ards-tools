package com.ards.jpa.model;

import java.io.Serializable;
import javax.persistence.*;


/**
 * The persistent class for the contest database table.
 * 
 */
@Entity
@Table(name="contest")
@NamedQuery(name="Contest.findAll", query="SELECT c FROM Contest c")
public class Contest implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@GeneratedValue(strategy=GenerationType.AUTO)
	@Column(unique=true, nullable=false)
	private Integer id;

	@Column(length=120)
	private String description;

	@Column(name="import_only", nullable=false)
	private Boolean importOnly;

	@Column(length=60)
	private String name;

	//bi-directional many-to-one association to Weblink
	@ManyToOne
	@JoinColumn(name="weblink_id")
	private Weblink weblink;

	public Contest() {
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

	public Boolean getImportOnly() {
		return this.importOnly;
	}

	public void setImportOnly(Boolean importOnly) {
		this.importOnly = importOnly;
	}

	public String getName() {
		return this.name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public Weblink getWeblink() {
		return this.weblink;
	}

	public void setWeblink(Weblink weblink) {
		this.weblink = weblink;
	}

}