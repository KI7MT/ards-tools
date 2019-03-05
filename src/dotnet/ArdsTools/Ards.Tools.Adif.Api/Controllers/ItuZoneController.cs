using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using Ards.Tools.Domain.Adif.Adif.Models;

namespace Ards.Tools.Adif.Api.Controllers
{
    [Route("api/ItuZone")]
    [ApiController]
    public class ItuZoneController : ControllerBase
    {
        private readonly AdifDomainContext _context;

        public ItuZoneController(AdifDomainContext context)
        {
            _context = context;
        }

        // GET: api/ItuZone
        [HttpGet]
        public async Task<ActionResult<IEnumerable<ItuZone>>> GetItuZone()
        {
            return await _context.ItuZone.ToListAsync();
        }

        // GET: api/ItuZone/5
        [HttpGet("{id}")]
        public async Task<ActionResult<ItuZone>> GetItuZone(int id)
        {
            var ituZone = await _context.ItuZone.FindAsync(id);

            if (ituZone == null)
            {
                return NotFound();
            }

            return ituZone;
        }

        // PUT: api/ItuZone/5
        [HttpPut("{id}")]
        public async Task<IActionResult> PutItuZone(int id, ItuZone ituZone)
        {
            if (id != ituZone.Id)
            {
                return BadRequest();
            }

            _context.Entry(ituZone).State = EntityState.Modified;

            try
            {
                await _context.SaveChangesAsync();
            }
            catch (DbUpdateConcurrencyException)
            {
                if (!ItuZoneExists(id))
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

        // POST: api/ItuZone
        [HttpPost]
        public async Task<ActionResult<ItuZone>> PostItuZone(ItuZone ituZone)
        {
            _context.ItuZone.Add(ituZone);
            try
            {
                await _context.SaveChangesAsync();
            }
            catch (DbUpdateException)
            {
                if (ItuZoneExists(ituZone.Id))
                {
                    return Conflict();
                }
                else
                {
                    throw;
                }
            }

            return CreatedAtAction("GetItuZone", new { id = ituZone.Id }, ituZone);
        }

        // DELETE: api/ItuZone/5
        [HttpDelete("{id}")]
        public async Task<ActionResult<ItuZone>> DeleteItuZone(int id)
        {
            var ituZone = await _context.ItuZone.FindAsync(id);
            if (ituZone == null)
            {
                return NotFound();
            }

            _context.ItuZone.Remove(ituZone);
            await _context.SaveChangesAsync();

            return ituZone;
        }

        private bool ItuZoneExists(int id)
        {
            return _context.ItuZone.Any(e => e.Id == id);
        }
    }
}
