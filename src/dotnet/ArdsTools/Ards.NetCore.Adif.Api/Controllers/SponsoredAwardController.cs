using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using Ards.NetCore.Adif.Domain.Models;

namespace Ards.NetCore.Adif.Api.Controllers
{
    [Route("api/SponsoredAward")]
    [ApiController]
    public class SponsoredAwardController : ControllerBase
    {
        private readonly AdifContext _context;

        public SponsoredAwardController(AdifContext context)
        {
            _context = context;
        }

        // GET: api/SponsoredAward
        [HttpGet]
        public async Task<ActionResult<IEnumerable<SponsoredAward>>> GetSponsoredAward()
        {
            return await _context.SponsoredAward.ToListAsync();
        }

        // GET: api/SponsoredAward/5
        [HttpGet("{id}")]
        public async Task<ActionResult<SponsoredAward>> GetSponsoredAward(int id)
        {
            var sponsoredAward = await _context.SponsoredAward.FindAsync(id);

            if (sponsoredAward == null)
            {
                return NotFound();
            }

            return sponsoredAward;
        }

        // PUT: api/SponsoredAward/5
        [HttpPut("{id}")]
        public async Task<IActionResult> PutSponsoredAward(int id, SponsoredAward sponsoredAward)
        {
            if (id != sponsoredAward.Id)
            {
                return BadRequest();
            }

            _context.Entry(sponsoredAward).State = EntityState.Modified;

            try
            {
                await _context.SaveChangesAsync();
            }
            catch (DbUpdateConcurrencyException)
            {
                if (!SponsoredAwardExists(id))
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

        // POST: api/SponsoredAward
        [HttpPost]
        public async Task<ActionResult<SponsoredAward>> PostSponsoredAward(SponsoredAward sponsoredAward)
        {
            _context.SponsoredAward.Add(sponsoredAward);
            await _context.SaveChangesAsync();

            return CreatedAtAction("GetSponsoredAward", new { id = sponsoredAward.Id }, sponsoredAward);
        }

        // DELETE: api/SponsoredAward/5
        [HttpDelete("{id}")]
        public async Task<ActionResult<SponsoredAward>> DeleteSponsoredAward(int id)
        {
            var sponsoredAward = await _context.SponsoredAward.FindAsync(id);
            if (sponsoredAward == null)
            {
                return NotFound();
            }

            _context.SponsoredAward.Remove(sponsoredAward);
            await _context.SaveChangesAsync();

            return sponsoredAward;
        }

        private bool SponsoredAwardExists(int id)
        {
            return _context.SponsoredAward.Any(e => e.Id == id);
        }
    }
}
