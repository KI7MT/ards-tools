using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using Ards.Tools.Domain.Adif.ViewModels;

namespace Ards.Tools.Adif.Api.Controllers
{
    /// <summary>
    /// ADIF III.B.3 Award Enumeration (import-only)
    /// </summary>
    [Route("api/Award")]
    [ApiController]
    public class AwardController : ControllerBase
    {
        private readonly AdifDomain _context;

        public AwardController(AdifDomain context)
        {
            _context = context;
        }

        /// <summary>
        /// Get all Award Enumerations
        /// </summary>
        /// <returns>Returns all Award Enumerations</returns>
        [Produces("application/json")]
        [HttpGet]
        public async Task<ActionResult<IEnumerable<Award>>> GetAward()
        {
            return await _context.Award.ToListAsync();
        }

        /// <summary>
        /// Get Award Enumeration by ID
        /// </summary>
        /// <param name="id"></param>
        /// <returns>Returns Award by ID</returns>
        [Produces("application/json")]
        [HttpGet("{id}")]
        public async Task<ActionResult<Award>> GetAward(int id)
        {
            var award = await _context.Award.FindAsync(id);

            if (award == null)
            {
                return NotFound();
            }

            return award;
        }

        /// <summary>
        /// Check if Award ID exists
        /// </summary>
        /// <param name="id"></param>
        /// <returns>Return True if Award ID exists</returns>
        private bool AwardExists(int id)
        {
            return _context.Award.Any(e => e.AwardId == id);
        }
    }
}
