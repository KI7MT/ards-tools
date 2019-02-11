package com.ards.jpa.model;

import java.io.Serializable;
import javax.persistence.*;


/**
 * The persistent class for the credit database table.
 * 
 */
@Entity
@Table(name="credit")
@NamedQuery(name="Credit.findAll", query="SELECT c FROM Credit c")
public class Credit implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@GeneratedValue(strategy=GenerationType.AUTO)
	@Column(unique=true, nullable=false)
	private Integer id;

	@Column(name="credit_for", nullable=false, length=24)
	private String creditFor;

	//bi-directional many-to-one association to CreditAward
	@ManyToOne
	@JoinColumn(name="award_id", nullable=false)
	private CreditAward creditAward;

	//bi-directional many-to-one association to CreditFacet
	@ManyToOne
	@JoinColumn(name="facet_id", nullable=false)
	private CreditFacet creditFacet;

	//bi-directional many-to-one association to CreditSponsor
	@ManyToOne
	@JoinColumn(name="sponsor_id", nullable=false)
	private CreditSponsor creditSponsor;

	public Credit() {
	}

	public Integer getId() {
		return this.id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getCreditFor() {
		return this.creditFor;
	}

	public void setCreditFor(String creditFor) {
		this.creditFor = creditFor;
	}

	public CreditAward getCreditAward() {
		return this.creditAward;
	}

	public void setCreditAward(CreditAward creditAward) {
		this.creditAward = creditAward;
	}

	public CreditFacet getCreditFacet() {
		return this.creditFacet;
	}

	public void setCreditFacet(CreditFacet creditFacet) {
		this.creditFacet = creditFacet;
	}

	public CreditSponsor getCreditSponsor() {
		return this.creditSponsor;
	}

	public void setCreditSponsor(CreditSponsor creditSponsor) {
		this.creditSponsor = creditSponsor;
	}

}