using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using Ards.Tools.Domain.Adif.ViewModels;

namespace Ards.Tools.Adif.Api.Controllers
{
    /// <summary>
    /// ADIF County Names. Used for State County Enumerations
    /// This table does not have a specific ADIF section.
    /// </summary>
    [Route("api/CountyName")]
    [ApiController]
    public class CountyNameController : ControllerBase
    {
        private readonly AdifDomain _context;

        public CountyNameController(AdifDomain context)
        {
            _context = context;
        }

        /// <summary>
        /// Get All County Names
        /// </summary>
        /// <returns>Returns All County Names</returns>
        [Produces("application/json")]
        [HttpGet]
        public async Task<ActionResult<IEnumerable<CountyName>>> GetCountyName()
        {
            return await _context.CountyName.ToListAsync();
        }

        /// <summary>
        /// Get County name by ID
        /// </summary>
        /// <param name="id"></param>
        /// <returns>Returns County Name by ID</returns>
        [Produces("application/json")]
        [HttpGet("{id}")]
        public async Task<ActionResult<CountyName>> GetCountyName(int id)
        {
            var countyName = await _context.CountyName.FindAsync(id);

            if (countyName == null)
            {
                return NotFound();
            }

            return countyName;
        }

        /// <summary>
        /// Check if County Name exists
        /// </summary>
        /// <param name="id"></param>
        /// <returns>Returns True if County Name Exists</returns>
        private bool CountyNameExists(int id)
        {
            return _context.CountyName.Any(e => e.CountyNameId == id);
        }
    }
}
