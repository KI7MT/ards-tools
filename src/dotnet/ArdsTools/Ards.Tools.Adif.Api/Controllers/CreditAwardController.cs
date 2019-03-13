using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using Ards.Tools.Domain.Adif.ViewModels;

namespace Ards.Tools.Adif.Api.Controllers
{
    /// <summary>
    /// ADIF III.B.7 Credit Enumeration. Credit Award is a Subsection of Credit 
    /// </summary>
    [Route("api/CreditAward")]
    [ApiController]
    public class CreditAwardController : ControllerBase
    {
        private readonly AdifDomain _context;

        public CreditAwardController(AdifDomain context)
        {
            _context = context;
        }

        /// <summary>
        /// Get All Credit Awards
        /// </summary>
        /// <returns>Returns All Credit Award Enumeration</returns>
        [Produces("application/json")]
        [HttpGet]
        public async Task<ActionResult<IEnumerable<CreditAward>>> GetCreditAward()
        {
            return await _context.CreditAward.ToListAsync();
        }

        /// <summary>
        /// Get Credit Award by ID
        /// </summary>
        /// <param name="id"></param>
        /// <returns>Returns Credit Award by ID</returns>
        [Produces("application/json")]
        [HttpGet("{id}")]
        public async Task<ActionResult<CreditAward>> GetCreditAward(int id)
        {
            var creditAward = await _context.CreditAward.FindAsync(id);

            if (creditAward == null)
            {
                return NotFound();
            }

            return creditAward;
        }

        /// <summary>
        /// Chek if Credit Award ID exists
        /// </summary>
        /// <param name="id"></param>
        /// <returns>Returns True if Credit Award ID exists</returns>
        private bool CreditAwardExists(int id)
        {
            return _context.CreditAward.Any(e => e.CreditAwardId == id);
        }
    }
}
