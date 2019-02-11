package model;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

/**
 * The Callsign mode represents the database entity for eQsl.cc
 * authenticity Guaranteed list.
 * 
 * @see <a href="http://www.eqsl.cc/qslcard/DownloadedFiles/AGMemberListDated.txt">eQsl Text File</a>
 * 
 * @author Greg Beam
 * @author www.ki7mt.com
 * @version 1.0.0,  &nbsp;
 * @since SDK1.8
 * 
 */

@Entity
@Table(name="eqsl_ag")
public class Callsign {

	@Id
	@GeneratedValue(strategy = GenerationType.AUTO)
    private long id;

    @Column(name="callsign", nullable = false,  unique = true)
    private String callsign;
    
    @Temporal(TemporalType.DATE)
    @Column(name="last_update", nullable = true)
    private Date last_update;

	/** JPA Null constructor
	 * 
	 */
    public Callsign() {}

    /** Default constructor
     * 
     * @param id           serial generated record id
     * @param callsign     call sign of the station or person
     * @param last_update  last time the record was updated from eqsl.cc
     * 
     */
    public Callsign(long id, String callsign, Date last_update) {
		this.id = id;
		this.callsign = callsign;
		this.last_update = last_update;
	}

	public long getId() {
		return id;
	}

	public void setId(long id) {
		this.id = id;
	}

	public String getCallsign() {
		return callsign;
	}

	public void setCallsign(String callsign) {
		this.callsign = callsign;
	}

	public Date getLast_update() {
		return last_update;
	}

	public void setLast_update(Date last_update) {
		this.last_update = last_update;
	}

	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + ((callsign == null) ? 0 : callsign.hashCode());
		result = prime * result + (int) (id ^ (id >>> 32));
		result = prime * result + ((last_update == null) ? 0 : last_update.hashCode());
		return result;
	} // end hashCode method


	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		Callsign other = (Callsign) obj;
		if (callsign == null) {
			if (other.callsign != null)
				return false;
		} else if (!callsign.equals(other.callsign))
			return false;
		if (id != other.id)
			return false;
		if (last_update == null) {
			if (other.last_update != null)
				return false;
		} else if (!last_update.equals(other.last_update))
			return false;
		return true;
	} // end equals method

} // end Entity class Callsign
