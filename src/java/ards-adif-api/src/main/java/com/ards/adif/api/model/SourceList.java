package com.ards.adif.api.model;

import java.io.Serializable;
import javax.persistence.*;
import java.util.Date;


/**
 * The persistent class for the source_list database table.
 * 
 */
@Entity
@Table(name="source_list")
@NamedQuery(name="SourceList.findAll", query="SELECT s FROM SourceList s")
public class SourceList implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@Column(unique=true, nullable=false)
	private Integer id;

	@Temporal(TemporalType.DATE)
	@Column(name="source_date", nullable=false)
	private Date sourceDate;

	@Column(name="source_name", nullable=false, length=2147483647)
	private String sourceName;

	@Temporal(TemporalType.DATE)
	@Column(name="verified_date", nullable=false)
	private Date verifiedDate;

	//bi-directional many-to-one association to Weblink
	@ManyToOne
	@JoinColumn(name="weblink_id", nullable=false)
	private Weblink weblink;

	public SourceList() {
	}

	public Integer getId() {
		return this.id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public Date getSourceDate() {
		return this.sourceDate;
	}

	public void setSourceDate(Date sourceDate) {
		this.sourceDate = sourceDate;
	}

	public String getSourceName() {
		return this.sourceName;
	}

	public void setSourceName(String sourceName) {
		this.sourceName = sourceName;
	}

	public Date getVerifiedDate() {
		return this.verifiedDate;
	}

	public void setVerifiedDate(Date verifiedDate) {
		this.verifiedDate = verifiedDate;
	}

	public Weblink getWeblink() {
		return this.weblink;
	}

	public void setWeblink(Weblink weblink) {
		this.weblink = weblink;
	}

}