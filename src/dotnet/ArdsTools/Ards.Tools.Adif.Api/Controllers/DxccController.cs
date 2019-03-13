using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using Ards.Tools.Domain.Adif.ViewModels;

namespace Ards.Tools.Adif.Api.Controllers
{
    /// <summary>
    /// ADIF III.B.8 DXCC Entity Code Enumeration
    /// </summary>
    [Route("api/Dxcc")]
    [ApiController]
    public class DxccController : ControllerBase
    {
        private readonly AdifDomain _context;

        public DxccController(AdifDomain context)
        {
            _context = context;
        }

        /// <summary>
        /// Get all DXCC Entities
        /// </summary>
        /// <returns>Return All DXCC Entities</returns>
        [Route("api/CreditSponsor")]
        [HttpGet]
        public async Task<ActionResult<IEnumerable<Dxcc>>> GetDxcc()
        {
            return await _context.Dxcc.ToListAsync();
        }

        /// <summary>
        /// Get DXCC Entity by ID. The ID is the same as the XCC Code for each country
        /// </summary>
        /// <param name="id"></param>
        /// <param name="dxcc"></param>
        /// <returns>Retrun DXCC Entity by ID</returns>
        [Route("api/CreditSponsor")]
        [HttpGet("{id}")]
        public async Task<ActionResult<Dxcc>> GetDxcc(int id)
        {
            var dxcc = await _context.Dxcc.FindAsync(id);

            if (dxcc == null)
            {
                return NotFound();
            }

            return dxcc;
        }

        /// <summary>
        /// Check if DXCC Entity exists by ID
        /// </summary>
        /// <param name="id"></param>
        /// <returns>Returns True if DXCC Entity exists</returns>
        private bool DxccExists(int id)
        {
            return _context.Dxcc.Any(e => e.DxccId == id);
        }
    }
}
