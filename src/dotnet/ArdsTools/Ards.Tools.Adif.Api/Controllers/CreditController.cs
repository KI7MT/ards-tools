using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using Ards.Tools.Domain.Adif.ViewModels;

namespace Ards.Tools.Adif.Api.Controllers
{
    /// <summary>
    /// ADIF III.B.7 Credit Enumeration
    /// </summary>
    [Route("api/Credit")]
    [ApiController]
    public class CreditController : ControllerBase
    {
        private readonly AdifDomain _context;

        public CreditController(AdifDomain context)
        {
            _context = context;
        }

        /// <summary>
        /// Get all Credit Enumeration
        /// </summary>
        /// <returns>Returns all Credit enumerations</returns>
        [Produces("application/json")]
        [HttpGet]
        public async Task<ActionResult<IEnumerable<Credit>>> GetCredit()
        {
            return await _context.Credit.ToListAsync();
        }

        /// <summary>
        /// Get Credit by ID
        /// </summary>
        /// <param name="id"></param>
        /// <returns>Returns Credit by ID</returns>
        [Produces("application/json")]
        [HttpGet("{id}")]
        public async Task<ActionResult<Credit>> GetCredit(int id)
        {
            var credit = await _context.Credit.FindAsync(id);

            if (credit == null)
            {
                return NotFound();
            }

            return credit;
        }

        /// <summary>
        /// Check if Credit exists
        /// </summary>
        /// <param name="id"></param>
        /// <returns>Returns True if Credit Exists</returns>
        private bool CreditExists(int id)
        {
            return _context.Credit.Any(e => e.CreditId == id);
        }
    }
}
