using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using Ards.Tools.Domain.Adif.ViewModels;

namespace Ards.Tools.Adif.Api.Controllers
{
    /// <summary>
    /// ADIF III.B.1 Ant Path Enumeration
    /// </summary>
    [Route("api/AntennaPath")]
    [ApiController]
    public class AntennaPathController : ControllerBase
    {
        private readonly AdifDomain _context;

        public AntennaPathController(AdifDomain context)
        {
            _context = context;
        }

        /// <summary>
        /// Get all Antenna Path Enumerations
        /// </summary>
        /// <returns>Returns all Antenna Path Enumerations</returns>
        [Produces("application/json")]
        [HttpGet]
        public async Task<ActionResult<IEnumerable<AntennaPath>>> GetAntennaPath()
        {
            return await _context.AntennaPath.ToListAsync();
        }

        /// <summary>
        /// Get Antenna Path Enumeration by ID
        /// </summary>
        /// <param name="id"></param>
        /// <returns>Returns Antenna by ID</returns>
        [Produces("application/json")]
        [HttpGet("{id}")]
        public async Task<ActionResult<AntennaPath>> GetAntennaPath(int id)
        {
            var antennaPath = await _context.AntennaPath.FindAsync(id);

            if (antennaPath == null)
            {
                return NotFound();
            }

            return antennaPath;
        }

        /// <summary>
        /// Check is Antenna Path ID Exists
        /// </summary>
        /// <param name="id"></param>
        /// <returns>Returns True if Antenna Path ID exists</returns>
        private bool AntennaPathExists(int id)
        {
            return _context.AntennaPath.Any(e => e.AntennaPathId == id);
        }
    }
}
