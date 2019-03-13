using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using Ards.Tools.Domain.Adif.ViewModels;

namespace Ards.Tools.Adif.Api.Controllers
{
    /// <summary>
    /// ADIF III.B.2 ARRL Section Enumeration
    /// </summary>
    [Route("api/ArrlSection")]
    [ApiController]
    public class ArrlSectionController : ControllerBase
    {
        private readonly AdifDomain _context;

        public ArrlSectionController(AdifDomain context)
        {
            _context = context;
        }

        /// <summary>
        /// Get All ARRL Section Enumerations
        /// </summary>
        /// <returns>Returns all ARRL Sections</returns>
        [Produces("application/json")]
        [HttpGet]
        public async Task<ActionResult<IEnumerable<ArrlSection>>> GetArrlSection()
        {
            return await _context.ArrlSection.ToListAsync();
        }

        /// <summary>
        /// Get ARRL Section by ID
        /// </summary>
        /// <param name="id"></param>
        /// <returns>Returns ARRL Section by ID</returns>
        [Produces("application/json")]
        [HttpGet("{id}")]
        public async Task<ActionResult<ArrlSection>> GetArrlSection(int id)
        {
            var arrlSection = await _context.ArrlSection.FindAsync(id);

            if (arrlSection == null)
            {
                return NotFound();
            }

            return arrlSection;
        }

        /// <summary>
        /// Check is ARRL Section ID exists
        /// </summary>
        /// <param name="id"></param>
        /// <returns>Returns True if ARRL Section Exists</returns>
        private bool ArrlSectionExists(int id)
        {
            return _context.ArrlSection.Any(e => e.ArrlSectionId == id);
        }
    }
}
