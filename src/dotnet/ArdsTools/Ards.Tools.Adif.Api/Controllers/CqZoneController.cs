using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using Ards.Tools.Domain.Adif.Adif.Models;

namespace Ards.Tools.Adif.Api.Controllers
{
    [Route("api/CqZone")]
    [ApiController]
    public class CqZoneController : ControllerBase
    {
        private readonly AdifDomainContext _context;

        public CqZoneController(AdifDomainContext context)
        {
            _context = context;
        }

        // GET: api/CqZone
        [HttpGet]
        public async Task<ActionResult<IEnumerable<CqZone>>> GetCqZone()
        {
            return await _context.CqZone.ToListAsync();
        }

        // GET: api/CqZone/5
        [HttpGet("{id}")]
        public async Task<ActionResult<CqZone>> GetCqZone(int id)
        {
            var cqZone = await _context.CqZone.FindAsync(id);

            if (cqZone == null)
            {
                return NotFound();
            }

            return cqZone;
        }

        // PUT: api/CqZone/5
        [HttpPut("{id}")]
        public async Task<IActionResult> PutCqZone(int id, CqZone cqZone)
        {
            if (id != cqZone.Id)
            {
                return BadRequest();
            }

            _context.Entry(cqZone).State = EntityState.Modified;

            try
            {
                await _context.SaveChangesAsync();
            }
            catch (DbUpdateConcurrencyException)
            {
                if (!CqZoneExists(id))
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

        // POST: api/CqZone
        [HttpPost]
        public async Task<ActionResult<CqZone>> PostCqZone(CqZone cqZone)
        {
            _context.CqZone.Add(cqZone);
            try
            {
                await _context.SaveChangesAsync();
            }
            catch (DbUpdateException)
            {
                if (CqZoneExists(cqZone.Id))
                {
                    return Conflict();
                }
                else
                {
                    throw;
                }
            }

            return CreatedAtAction("GetCqZone", new { id = cqZone.Id }, cqZone);
        }

        // DELETE: api/CqZone/5
        [HttpDelete("{id}")]
        public async Task<ActionResult<CqZone>> DeleteCqZone(int id)
        {
            var cqZone = await _context.CqZone.FindAsync(id);
            if (cqZone == null)
            {
                return NotFound();
            }

            _context.CqZone.Remove(cqZone);
            await _context.SaveChangesAsync();

            return cqZone;
        }

        private bool CqZoneExists(int id)
        {
            return _context.CqZone.Any(e => e.Id == id);
        }
    }
}
