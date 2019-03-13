using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using Ards.Tools.Domain.Adif.ViewModels;

namespace Ards.Tools.Adif.Api.Controllers
{
    /// <summary>
    /// ADIF III.B.7 Credit Enumeration. Credit Facet is a Subsection of Credit 
    /// </summary>
    [Route("api/CreditFacet")]
    [ApiController]
    public class CreditFacetController : ControllerBase
    {
        private readonly AdifDomain _context;

        public CreditFacetController(AdifDomain context)
        {
            _context = context;
        }

        /// <summary>
        /// Get All Credit Facets
        /// </summary>
        /// <returns>Returns all Credit Facets</returns>
        [Produces("application/json")]
        [HttpGet]
        public async Task<ActionResult<IEnumerable<CreditFacet>>> GetCreditFacet()
        {
            return await _context.CreditFacet.ToListAsync();
        }


        /// <summary>
        /// Get Credit Facet by ID
        /// </summary>
        /// <param name="id"></param>
        /// <returns>Returns Credit Facet by ID</returns>
        [Produces("application/json")]
        [HttpGet("{id}")]
        public async Task<ActionResult<CreditFacet>> GetCreditFacet(int id)
        {
            var creditFacet = await _context.CreditFacet.FindAsync(id);

            if (creditFacet == null)
            {
                return NotFound();
            }

            return creditFacet;
        }

        /// <summary>
        /// Check if Credit Facet exists
        /// </summary>
        /// <param name="id"></param>
        /// <returns>Returns True if Credit fact exists</returns>
        private bool CreditFacetExists(int id)
        {
            return _context.CreditFacet.Any(e => e.CreditFacetId == id);
        }
    }
}
