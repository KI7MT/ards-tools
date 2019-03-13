using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using Ards.Tools.Domain.Adif.ViewModels;

namespace Ards.Tools.Adif.Api.Controllers
{
    /// <summary>
    /// IARU Regions. This Table is not part of the ADIF Spec.
    /// </summary>
    [Route("api/IaruRegion")]
    [ApiController]
    public class IaruRegionController : ControllerBase
    {
        private readonly AdifDomain _context;

        public IaruRegionController(AdifDomain context)
        {
            _context = context;
        }

        /// <summary>
        /// Get ALl IARU Regions
        /// </summary>
        /// <returns>Returns All IARU Regions</returns>
        [Produces("application/json")]
        [HttpGet]
        public async Task<ActionResult<IEnumerable<IaruRegion>>> GetIaruRegion()
        {
            return await _context.IaruRegion.ToListAsync();
        }

        /// <summary>
        /// Get IARU Region by ID
        /// </summary>
        /// <param name="id"></param>
        /// <returns>Returns IARU Region by ID</returns>
        [Produces("application/json")]
        [HttpGet("{id}")]
        public async Task<ActionResult<IaruRegion>> GetIaruRegion(int id)
        {
            var iaruRegion = await _context.IaruRegion.FindAsync(id);

            if (iaruRegion == null)
            {
                return NotFound();
            }

            return iaruRegion;
        }

        /// <summary>
        /// Check if IARU Region exists
        /// </summary>
        /// <param name="id"></param>
        /// <returns>Returns True is IARU Region exists</returns>
        private bool IaruRegionExists(int id)
        {
            return _context.IaruRegion.Any(e => e.IaruRegionId == id);
        }
    }
}
