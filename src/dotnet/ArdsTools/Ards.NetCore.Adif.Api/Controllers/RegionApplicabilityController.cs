using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using Ards.NetCore.Adif.Domain.Models;

namespace Ards.NetCore.Adif.Api.Controllers
{
    [Route("api/RegionApplicability")]
    [ApiController]
    public class RegionApplicabilityController : ControllerBase
    {
        private readonly AdifContext _context;

        public RegionApplicabilityController(AdifContext context)
        {
            _context = context;
        }

        // GET: api/RegionApplicability
        [HttpGet]
        public async Task<ActionResult<IEnumerable<RegionApplicability>>> GetRegionApplicability()
        {
            return await _context.RegionApplicability.ToListAsync();
        }

        // GET: api/RegionApplicability/5
        [HttpGet("{id}")]
        public async Task<ActionResult<RegionApplicability>> GetRegionApplicability(int id)
        {
            var regionApplicability = await _context.RegionApplicability.FindAsync(id);

            if (regionApplicability == null)
            {
                return NotFound();
            }

            return regionApplicability;
        }

        // PUT: api/RegionApplicability/5
        [HttpPut("{id}")]
        public async Task<IActionResult> PutRegionApplicability(int id, RegionApplicability regionApplicability)
        {
            if (id != regionApplicability.Id)
            {
                return BadRequest();
            }

            _context.Entry(regionApplicability).State = EntityState.Modified;

            try
            {
                await _context.SaveChangesAsync();
            }
            catch (DbUpdateConcurrencyException)
            {
                if (!RegionApplicabilityExists(id))
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

        // POST: api/RegionApplicability
        [HttpPost]
        public async Task<ActionResult<RegionApplicability>> PostRegionApplicability(RegionApplicability regionApplicability)
        {
            _context.RegionApplicability.Add(regionApplicability);
            await _context.SaveChangesAsync();

            return CreatedAtAction("GetRegionApplicability", new { id = regionApplicability.Id }, regionApplicability);
        }

        // DELETE: api/RegionApplicability/5
        [HttpDelete("{id}")]
        public async Task<ActionResult<RegionApplicability>> DeleteRegionApplicability(int id)
        {
            var regionApplicability = await _context.RegionApplicability.FindAsync(id);
            if (regionApplicability == null)
            {
                return NotFound();
            }

            _context.RegionApplicability.Remove(regionApplicability);
            await _context.SaveChangesAsync();

            return regionApplicability;
        }

        private bool RegionApplicabilityExists(int id)
        {
            return _context.RegionApplicability.Any(e => e.Id == id);
        }
    }
}
