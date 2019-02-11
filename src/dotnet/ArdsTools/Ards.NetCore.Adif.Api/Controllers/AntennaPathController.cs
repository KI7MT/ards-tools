using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using Ards.NetCore.Adif.Domain.Models;

namespace Ards.NetCore.Adif.Api.Controllers
{
    [Route("api/AntennaPath")]
    [ApiController]
    public class AntennaPathController : ControllerBase
    {
        private readonly AdifContext _context;

        public AntennaPathController(AdifContext context)
        {
            _context = context;
        }

        // GET: api/AntennaPath
        [HttpGet]
        public async Task<ActionResult<IEnumerable<AntennaPath>>> GetAntennaPath()
        {
            return await _context.AntennaPath.ToListAsync();
        }

        // GET: api/AntennaPath/5
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
        [HttpPost]
        public async Task<ActionResult<AntennaPath>> PostAntennaPath(AntennaPath antennaPath)
        {
            _context.AntennaPath.Add(antennaPath);
            await _context.SaveChangesAsync();

            return CreatedAtAction("GetAntennaPath", new { id = antennaPath.Id }, antennaPath);
        }

        // DELETE: api/AntennaPath/5
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
