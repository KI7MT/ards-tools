using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using Ards.Tools.Domain.Adif.ViewModels;

namespace Ards.Tools.Adif.Api.Controllers
{
    /// <summary>
    /// ADIF III.B.12 Secondary Administrative Subdivision Enumeration
    /// JARL JCC Stats. Current and Delted JCC Entity Summary
    /// </summary>
    [Route("api/JccFullStats")]
    [ApiController]
    public class JccFullStatsController : ControllerBase
    {
        private readonly AdifDomain _context;

        public JccFullStatsController(AdifDomain context)
        {
            _context = context;
        }

        /// <summary>
        /// Get JARL Jcc Status Summary
        /// </summary>
        /// <returns></returns>
        [Produces("application/json")]
        [HttpGet]
        public async Task<ActionResult<IEnumerable<JccFullStats>>> GetJccFullStats()
        {
            return await _context.JccFullStats.ToListAsync();
        }

        /// <summary>
        /// Get JARL Jcc Status Summary by ID
        /// </summary>
        /// <param name="id"></param>
        /// <returns></returns>
        [Produces("application/json")]
        [HttpGet("{id}")]
        public async Task<ActionResult<JccFullStats>> GetJccFullStats(int id)
        {
            var jccFullStats = await _context.JccFullStats.FindAsync(id);

            if (jccFullStats == null)
            {
                return NotFound();
            }

            return jccFullStats;
        }

        /// <summary>
        /// Check if JARL JCC Stats exist by ID
        /// </summary>
        /// <param name="id"></param>
        /// <returns>Returns True if JARL JCC Stats by ID exists</returns>
        private bool JccFullStatsExists(int id)
        {
            return _context.JccFullStats.Any(e => e.JccFullStatsId == id);
        }
    }
}
