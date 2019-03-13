using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using Ards.Tools.Domain.Adif.ViewModels;

namespace Ards.Tools.Adif.Api.Controllers
{
    /// <summary>
    /// ADIF III.B.4 Band Enumeration
    /// </summary>
    [Route("api/Band")]
    [ApiController]
    public class BandController : ControllerBase
    {
        private readonly AdifDomain _context;

        public BandController(AdifDomain context)
        {
            _context = context;
        }

        /// <summary>
        /// Get All Band Enumerations
        /// </summary>
        /// <returns>Returns all Band Enumerations</returns>
        [Produces("application/json")]
        [HttpGet]
        public async Task<ActionResult<IEnumerable<Band>>> GetBand()
        {
            return await _context.Band.ToListAsync();
        }

        /// <summary>
        /// Get Band Enumeration by ID
        /// </summary>
        /// <param name="id"></param>
        /// <returns>Returns Band by ID</returns>
        [Produces("application/json")]
        [HttpGet("{id}")]
        public async Task<ActionResult<Band>> GetBand(int id)
        {
            var band = await _context.Band.FindAsync(id);

            if (band == null)
            {
                return NotFound();
            }

            return band;
        }

        /// <summary>
        /// Check if bad exists
        /// </summary>
        /// <param name="id"></param>
        /// <returns>Returns True if Band exists</returns>
        private bool BandExists(int id)
        {
            return _context.Band.Any(e => e.BandId == id);
        }
    }
}
