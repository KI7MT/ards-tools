package com.ards.jpa.model;

import java.io.Serializable;
import javax.persistence.*;
import java.util.List;


/**
 * The persistent class for the weblink database table.
 * 
 */
@Entity
@Table(name="weblink")
@NamedQuery(name="Weblink.findAll", query="SELECT w FROM Weblink w")
public class Weblink implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@GeneratedValue(strategy=GenerationType.AUTO)
	@Column(unique=true, nullable=false)
	private Integer id;

	@Column(name="display_text", nullable=false, length=120)
	private String displayText;

	@Column(nullable=false, length=255)
	private String url;

	//bi-directional many-to-one association to Contest
	@OneToMany(mappedBy="weblink")
	private List<Contest> contests;

	public Weblink() {
	}

	public Integer getId() {
		return this.id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getDisplayText() {
		return this.displayText;
	}

	public void setDisplayText(String displayText) {
		this.displayText = displayText;
	}

	public String getUrl() {
		return this.url;
	}

	public void setUrl(String url) {
		this.url = url;
	}

	public List<Contest> getContests() {
		return this.contests;
	}

	public void setContests(List<Contest> contests) {
		this.contests = contests;
	}

	public Contest addContest(Contest contest) {
		getContests().add(contest);
		contest.setWeblink(this);

		return contest;
	}

	public Contest removeContest(Contest contest) {
		getContests().remove(contest);
		contest.setWeblink(null);

		return contest;
	}

}