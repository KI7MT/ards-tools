package com.ards.mvc.models;

import java.io.Serializable;
import javax.persistence.*;
import java.sql.Timestamp;


/**
 * The persistent class for the schema_info database table.
 * 
 */
@Entity
@Table(name="schema_info")
public class SchemaInfo implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@GeneratedValue(strategy=GenerationType.AUTO)
	@Column(name="schema_name", unique=true, nullable=false, length=10)
	private String schemaName;

	@Column(name="adif_spec", length=10)
	private String adifSpec;

	@Column(name="last_update")
	private Timestamp lastUpdate;

	@Column(name="schema_version", length=10)
	private String schemaVersion;

	public SchemaInfo() {
	}

	public String getSchemaName() {
		return this.schemaName;
	}

	public void setSchemaName(String schemaName) {
		this.schemaName = schemaName;
	}

	public String getAdifSpec() {
		return this.adifSpec;
	}

	public void setAdifSpec(String adifSpec) {
		this.adifSpec = adifSpec;
	}

	public Timestamp getLastUpdate() {
		return this.lastUpdate;
	}

	public void setLastUpdate(Timestamp lastUpdate) {
		this.lastUpdate = lastUpdate;
	}

	public String getSchemaVersion() {
		return this.schemaVersion;
	}

	public void setSchemaVersion(String schemaVersion) {
		this.schemaVersion = schemaVersion;
	}

	@Override
	public String toString() {
		return "SchemaInfo [schemaName=" + schemaName + ", adifSpec=" + adifSpec + ", lastUpdate=" + lastUpdate
				+ ", schemaVersion=" + schemaVersion + "]";
	}
}