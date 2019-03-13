using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using Ards.Tools.Domain.Adif.ViewModels;

namespace Ards.Tools.Adif.Api.Controllers
{
    /// <summary>
    /// ADIF CQ Zones.
    /// This table does not ahve a specific ADIF section.
    /// </summary>
    [Route("api/Cqzone")]
    [ApiController]
    public class CqzoneController : ControllerBase
    {
        private readonly AdifDomain _context;

        public CqzoneController(AdifDomain context)
        {
            _context = context;
        }

        /// <summary>
        /// Get All CQ Zones
        /// </summary>
        /// <returns>Returns All CQ Zones</returns>
        [Produces("application/json")]
        [HttpGet]
        public async Task<ActionResult<IEnumerable<Cqzone>>> GetCqzone()
        {
            return await _context.Cqzone.ToListAsync();
        }

        /// <summary>
        /// Get CQ Zone by ID
        /// </summary>
        /// <param name="id"></param>
        /// <returns>Returns CQ Zone by ID</returns>
        [Produces("application/json")]
        [HttpGet("{id}")]
        public async Task<ActionResult<Cqzone>> GetCqzone(int id)
        {
            var cqzone = await _context.Cqzone.FindAsync(id);

            if (cqzone == null)
            {
                return NotFound();
            }

            return cqzone;
        }
        
        /// <summary>
        /// Check if CQ Zone ID exists
        /// </summary>
        /// <param name="id"></param>
        /// <returns>Returns True if CQ Zone ID exists</returns>
        private bool CqzoneExists(int id)
        {
            return _context.Cqzone.Any(e => e.CqzoneId == id);
        }
    }
}
