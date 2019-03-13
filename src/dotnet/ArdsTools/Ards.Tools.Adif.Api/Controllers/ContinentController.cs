using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using Ards.Tools.Domain.Adif.ViewModels;

namespace Ards.Tools.Adif.Api.Controllers
{
    /// <summary>
    /// ADIF III.B.6 Continent Enumeration
    /// </summary>
    [Route("api/Continent")]
    [ApiController]
    public class ContinentController : ControllerBase
    {
        private readonly AdifDomain _context;

        public ContinentController(AdifDomain context)
        {
            _context = context;
        }

        /// <summary>
        /// Get All Continents
        /// </summary>
        /// <returns>Returns all continents</returns>
        [Produces("application/json")]
        [HttpGet]
        public async Task<ActionResult<IEnumerable<Continent>>> GetContinent()
        {
            return await _context.Continent.ToListAsync();
        }

        /// <summary>
        /// Get Continent by ID
        /// </summary>
        /// <param name="id"></param>
        /// <returns>Returns Continent by ID</returns>
        [Produces("application/json")]
        [HttpGet("{id}")]
        public async Task<ActionResult<Continent>> GetContinent(int id)
        {
            var continent = await _context.Continent.FindAsync(id);

            if (continent == null)
            {
                return NotFound();
            }

            return continent;
        }

        /// <summary>
        /// Check if Contienet exists
        /// </summary>
        /// <param name="id"></param>
        /// <returns>Returns true if Continent exists</returns>
        private bool ContinentExists(int id)
        {
            return _context.Continent.Any(e => e.ContinentId == id);
        }
    }
}
