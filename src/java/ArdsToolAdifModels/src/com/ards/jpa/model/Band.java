package com.ards.jpa.model;

import java.io.Serializable;
import javax.persistence.*;
import java.math.BigDecimal;


/**
 * The persistent class for the band database table.
 * 
 */
@Entity
@Table(name="band")
@NamedQuery(name="Band.findAll", query="SELECT b FROM Band b")
public class Band implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@GeneratedValue(strategy=GenerationType.AUTO)
	@Column(unique=true, nullable=false)
	private Integer id;

	@Column(name="lower_freq", nullable=false, precision=131089)
	private BigDecimal lowerFreq;

	@Column(nullable=false, length=6)
	private String name;

	@Column(name="upper_freq", nullable=false, precision=131089)
	private BigDecimal upperFreq;

	public Band() {
	}

	public Integer getId() {
		return this.id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public BigDecimal getLowerFreq() {
		return this.lowerFreq;
	}

	public void setLowerFreq(BigDecimal lowerFreq) {
		this.lowerFreq = lowerFreq;
	}

	public String getName() {
		return this.name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public BigDecimal getUpperFreq() {
		return this.upperFreq;
	}

	public void setUpperFreq(BigDecimal upperFreq) {
		this.upperFreq = upperFreq;
	}

}