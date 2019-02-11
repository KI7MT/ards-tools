package com.ards.jpa.model;

import java.io.Serializable;
import javax.persistence.*;
import java.sql.Time;
import java.util.Date;


/**
 * The persistent class for the lotw_activity database table.
 * 
 */
@Entity
@Table(name="lotw_activity")
@NamedQuery(name="LotwActivity.findAll", query="SELECT l FROM LotwActivity l")
public class LotwActivity implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@GeneratedValue(strategy=GenerationType.AUTO)
	@Column(unique=true, nullable=false, length=2147483647)
	private String callsign;

	@Column(name="last_time", nullable=false)
	private Time lastTime;

	@Temporal(TemporalType.DATE)
	@Column(name="last_update", nullable=false)
	private Date lastUpdate;

	public LotwActivity() {
	}

	public String getCallsign() {
		return this.callsign;
	}

	public void setCallsign(String callsign) {
		this.callsign = callsign;
	}

	public Time getLastTime() {
		return this.lastTime;
	}

	public void setLastTime(Time lastTime) {
		this.lastTime = lastTime;
	}

	public Date getLastUpdate() {
		return this.lastUpdate;
	}

	public void setLastUpdate(Date lastUpdate) {
		this.lastUpdate = lastUpdate;
	}

}