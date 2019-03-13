using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using Ards.Tools.Domain.Adif.ViewModels;

namespace Ards.Tools.Adif.Api.Controllers
{
    /// <summary>
    /// ADIF III.B.7 Credit Enumeration. Credit Sponsor is a Subsection of Credit 
    /// </summary>
    [Route("api/CreditSponsor")]
    [ApiController]
    public class CreditSponsorController : ControllerBase
    {
        private readonly AdifDomain _context;

        public CreditSponsorController(AdifDomain context)
        {
            _context = context;
        }

        /// <summary>
        /// Get All Credit Sponsors
        /// </summary>
        /// <returns>Returns All Credit Sponsors</returns>
        [Produces("application/json")]
        [HttpGet]
        public async Task<ActionResult<IEnumerable<CreditSponsor>>> GetCreditSponsor()
        {
            return await _context.CreditSponsor.ToListAsync();
        }

        /// <summary>
        /// Get Credit Sponsor by ID
        /// </summary>
        /// <param name="id"></param>
        /// <returns>Return Credit Sponsor by ID</returns>
        [Produces("application/json")]
        [HttpGet("{id}")]
        public async Task<ActionResult<CreditSponsor>> GetCreditSponsor(int id)
        {
            var creditSponsor = await _context.CreditSponsor.FindAsync(id);

            if (creditSponsor == null)
            {
                return NotFound();
            }

            return creditSponsor;
        }

        /// <summary>
        /// Check if Credit Sponsor ID exists
        /// </summary>
        /// <param name="id"></param>
        /// <returns>Returns True if Credit Sponsor ID exists</returns>
        private bool CreditSponsorExists(int id)
        {
            return _context.CreditSponsor.Any(e => e.CreditSponsorId == id);
        }
    }
}
