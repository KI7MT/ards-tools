package com.ards.jpa.model;

import java.io.Serializable;
import javax.persistence.*;
import java.util.Date;


/**
 * The persistent class for the jtalert_data database table.
 * 
 */
@Entity
@Table(name="jtalert_data")
@NamedQuery(name="JtalertData.findAll", query="SELECT j FROM JtalertData j")
public class JtalertData implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@GeneratedValue(strategy=GenerationType.AUTO)
	@Column(unique=true, nullable=false, length=20)
	private String call;

	private Boolean eqsl;

	private Boolean lotw;

	@Temporal(TemporalType.DATE)
	@Column(name="lotw_date")
	private Date lotwDate;

	@Column(length=4)
	private String state;

	public JtalertData() {
	}

	public String getCall() {
		return this.call;
	}

	public void setCall(String call) {
		this.call = call;
	}

	public Boolean getEqsl() {
		return this.eqsl;
	}

	public void setEqsl(Boolean eqsl) {
		this.eqsl = eqsl;
	}

	public Boolean getLotw() {
		return this.lotw;
	}

	public void setLotw(Boolean lotw) {
		this.lotw = lotw;
	}

	public Date getLotwDate() {
		return this.lotwDate;
	}

	public void setLotwDate(Date lotwDate) {
		this.lotwDate = lotwDate;
	}

	public String getState() {
		return this.state;
	}

	public void setState(String state) {
		this.state = state;
	}

}