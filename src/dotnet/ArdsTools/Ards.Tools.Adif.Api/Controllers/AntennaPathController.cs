using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using Ards.Tools.Domain.Adif.Adif.Models;

namespace Ards.Tools.Adif.Api.Controllers
{
    [Route("api/AntennaPath")]
    [ApiController]
    public class AntennaPathController : ControllerBase
    {
        private readonly AdifDomainContext _context;

        public AntennaPathController(AdifDomainContext context)
        {
            _context = context;
        }

        // GET: api/AntennaPath
        /// <summary>
        /// Display All Antenna Paths
        /// </summary>
        /// <returns></returns>
        [Produces("application/json")]
        [HttpGet]
        public async Task<ActionResult<IEnumerable<AntennaPath>>> GetAntennaPath()
        {
            return await _context.AntennaPath.ToListAsync();
        }

        // GET: api/AntennaPath/5
        /// <summary>
        /// Display Antenna Path for Specific ID
        /// </summary>
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

        // PUT: api/AntennaPath/5
        /// <summary>
        /// Update Antenna Path by ID
        /// </summary>
        [HttpPut("{id}")]
        public async Task<IActionResult> PutAntennaPath(int id, AntennaPath antennaPath)
        {
            if (id != antennaPath.Id)
            {
                return BadRequest();
            }

            _context.Entry(antennaPath).State = EntityState.Modified;

            try
            {
                await _context.SaveChangesAsync();
            }
            catch (DbUpdateConcurrencyException)
            {
                if (!AntennaPathExists(id))
                {
                    return NotFound();
                }
                else
                {
                    throw;
                }
            }

            return NoContent();
        }

        // POST: api/AntennaPath
        /// <summary>
        /// Add New Antenna Path
        /// </summary>
        [HttpPost]
        public async Task<ActionResult<AntennaPath>> PostAntennaPath(AntennaPath antennaPath)
        {
            _context.AntennaPath.Add(antennaPath);
            await _context.SaveChangesAsync();

            return CreatedAtAction("GetAntennaPath", new { id = antennaPath.Id }, antennaPath);
        }

        // DELETE: api/AntennaPath/5
        /// <summary>
        /// Delete Antenna Path by ID
        /// </summary>
        [HttpDelete("{id}")]
        public async Task<ActionResult<AntennaPath>> DeleteAntennaPath(int id)
        {
            var antennaPath = await _context.AntennaPath.FindAsync(id);
            if (antennaPath == null)
            {
                return NotFound();
            }

            _context.AntennaPath.Remove(antennaPath);
            await _context.SaveChangesAsync();

            return antennaPath;
        }

        private bool AntennaPathExists(int id)
        {
            return _context.AntennaPath.Any(e => e.Id == id);
        }
    }
}
