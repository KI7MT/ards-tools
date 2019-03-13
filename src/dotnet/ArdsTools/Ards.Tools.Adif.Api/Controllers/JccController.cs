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
    /// This list is the JARL JCC List DXCC 339
    /// </summary>
    [Route("api/Jcc")]
    [ApiController]
    public class JccController : ControllerBase
    {
        private readonly AdifDomain _context;

        public JccController(AdifDomain context)
        {
            _context = context;
        }

        /// <summary>
        /// Get All JARL JCC Entities
        /// </summary>
        /// <returns>Returns All JARL JCC Entities</returns>
        [Produces("application/json")]
        [HttpGet]
        public async Task<ActionResult<IEnumerable<Jcc>>> GetJcc()
        {
            return await _context.Jcc.ToListAsync();
        }

        /// <summary>
        /// Get JARL JCC Entity by ID
        /// </summary>
        /// <param name="id"></param>
        /// <returns>Returns JARL JCC Entity by ID</returns>
        [Produces("application/json")]
        [HttpGet("{id}")]
        public async Task<ActionResult<Jcc>> GetJcc(int id)
        {
            var jcc = await _context.Jcc.FindAsync(id);

            if (jcc == null)
            {
                return NotFound();
            }

            return jcc;
        }

        /// <summary>
        /// Check if JARL JCC Entity exists by ID
        /// </summary>
        /// <param name="id"></param>
        /// <returns>Returns True if JARL JCC Entity Exists by ID</returns>
        private bool JccExists(int id)
        {
            return _context.Jcc.Any(e => e.JccId == id);
        }
    }
}
