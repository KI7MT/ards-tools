using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using Ards.Tools.Domain.Adif.ViewModels;

namespace Ards.Tools.Adif.Api.Controllers
{
    /// <summary>
    /// ADIF III.B.5 Contest ID Enumeration
    /// </summary>
    [Route("api/Contest")]
    [ApiController]
    public class ContestController : ControllerBase
    {
        private readonly AdifDomain _context;

        public ContestController(AdifDomain context)
        {
            _context = context;
        }

        /// <summary>
        /// Get all contest enumerations
        /// </summary>
        /// <returns>Returns the full list of contest enumerations</returns>
        [Produces("application/json")]
        [HttpGet]
        public async Task<ActionResult<IEnumerable<Contest>>> GetContest()
        {
            return await _context.Contest.ToListAsync();
        }

        /// <summary>
        /// Get contest enumeration by {id}
        /// </summary>
        /// <param name="id"></param>
        /// <returns>Returns contest data for a givein {id}</returns>
        [Produces("application/json")]
        [HttpGet("{id}")]
        public async Task<ActionResult<Contest>> GetContest(int id)
        {
            var contest = await _context.Contest.FindAsync(id);

            if (contest == null)
            {
                return NotFound();
            }

            return contest;
        }

        /// <summary>
        /// Check if Contest Exists
        /// </summary>
        /// <param name="id"></param>
        /// <returns>Returns True if Contest Exists</returns>
        private bool ContestExists(int id)
        {
            return _context.Contest.Any(e => e.ContestId == id);
        }
    }
}
