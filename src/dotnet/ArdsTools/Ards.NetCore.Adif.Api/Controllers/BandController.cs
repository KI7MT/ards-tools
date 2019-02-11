using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using Ards.NetCore.Adif.Domain.Models;

namespace Ards.NetCore.Adif.Api.Controllers
{
    [Route("api/Band")]
    [ApiController]
    public class BandController : ControllerBase
    {
        private readonly AdifContext _context;

        public BandController(AdifContext context)
        {
            _context = context;
        }

        // GET: api/Band
        [HttpGet]
        public async Task<ActionResult<IEnumerable<Band>>> GetBand()
        {
            return await _context.Band.ToListAsync();
        }

        // GET: api/Band/5
        [HttpGet("{id}")]
        public async Task<ActionResult<Band>> GetBand(int id)
        {
            var band = await _context.Band.FindAsync(id);

            if (band == null)
            {
                return NotFound();
            }

            return band;
        }

        // PUT: api/Band/5
        [HttpPut("{id}")]
        public async Task<IActionResult> PutBand(int id, Band band)
        {
            if (id != band.Id)
            {
                return BadRequest();
            }

            _context.Entry(band).State = EntityState.Modified;

            try
            {
                await _context.SaveChangesAsync();
            }
            catch (DbUpdateConcurrencyException)
            {
                if (!BandExists(id))
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

        // POST: api/Band
        [HttpPost]
        public async Task<ActionResult<Band>> PostBand(Band band)
        {
            _context.Band.Add(band);
            await _context.SaveChangesAsync();

            return CreatedAtAction("GetBand", new { id = band.Id }, band);
        }

        // DELETE: api/Band/5
        [HttpDelete("{id}")]
        public async Task<ActionResult<Band>> DeleteBand(int id)
        {
            var band = await _context.Band.FindAsync(id);
            if (band == null)
            {
                return NotFound();
            }

            _context.Band.Remove(band);
            await _context.SaveChangesAsync();

            return band;
        }

        private bool BandExists(int id)
        {
            return _context.Band.Any(e => e.Id == id);
        }
    }
}
