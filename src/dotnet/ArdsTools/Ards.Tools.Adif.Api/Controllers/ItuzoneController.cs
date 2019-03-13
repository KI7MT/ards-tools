using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using Ards.Tools.Domain.Adif.ViewModels;

namespace Ards.Tools.Adif.Api.Controllers
{
    /// <summary>
    /// ITU Zones. This table is not an ADIF Spec table, but supports many others.
    /// </summary>
    [Route("api/Ituzone")]
    [ApiController]
    public class ItuzoneController : ControllerBase
    {
        private readonly AdifDomain _context;

        public ItuzoneController(AdifDomain context)
        {
            _context = context;
        }

        /// <summary>
        /// Get All ITU Zones
        /// </summary>
        /// <returns>Returns ALl ITU Zones</returns>
        [Produces("application/json")]
        [HttpGet]
        public async Task<ActionResult<IEnumerable<Ituzone>>> GetItuzone()
        {
            return await _context.Ituzone.ToListAsync();
        }

        /// <summary>
        /// Get ITU ZOne by ID
        /// </summary>
        /// <param name="id"></param>
        /// <returns>Returns ITU ZOne by ID</returns>
        [Produces("application/json")]
        [HttpGet("{id}")]
        public async Task<ActionResult<Ituzone>> GetItuzone(int id)
        {
            var ituzone = await _context.Ituzone.FindAsync(id);

            if (ituzone == null)
            {
                return NotFound();
            }

            return ituzone;
        }

        /// <summary>
        /// Ckeck if ITU ZOne Exists by ID
        /// </summary>
        /// <param name="id"></param>
        /// <returns>Returns True if ITU ZOne exists by ID</returns>
        private bool ItuzoneExists(int id)
        {
            return _context.Ituzone.Any(e => e.ItuzoneId == id);
        }
    }
}
