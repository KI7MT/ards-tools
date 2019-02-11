using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using Ards.NetCore.Adif.Domain.Models;

namespace Ards.NetCore.Adif.Api.Controllers
{
    [Route("api/ArrlSection")]
    [ApiController]
    public class ArrlSectionController : ControllerBase
    {
        private readonly AdifContext _context;

        public ArrlSectionController(AdifContext context)
        {
            _context = context;
        }

        // GET: api/ArrlSection
        [HttpGet]
        public async Task<ActionResult<IEnumerable<ArrlSection>>> GetArrlSection()
        {
            return await _context.ArrlSection.ToListAsync();
        }

        // GET: api/ArrlSection/5
        [HttpGet("{id}")]
        public async Task<ActionResult<ArrlSection>> GetArrlSection(int id)
        {
            var arrlSection = await _context.ArrlSection.FindAsync(id);

            if (arrlSection == null)
            {
                return NotFound();
            }

            return arrlSection;
        }

        // PUT: api/ArrlSection/5
        [HttpPut("{id}")]
        public async Task<IActionResult> PutArrlSection(int id, ArrlSection arrlSection)
        {
            if (id != arrlSection.Id)
            {
                return BadRequest();
            }

            _context.Entry(arrlSection).State = EntityState.Modified;

            try
            {
                await _context.SaveChangesAsync();
            }
            catch (DbUpdateConcurrencyException)
            {
                if (!ArrlSectionExists(id))
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

        // POST: api/ArrlSection
        [HttpPost]
        public async Task<ActionResult<ArrlSection>> PostArrlSection(ArrlSection arrlSection)
        {
            _context.ArrlSection.Add(arrlSection);
            await _context.SaveChangesAsync();

            return CreatedAtAction("GetArrlSection", new { id = arrlSection.Id }, arrlSection);
        }

        // DELETE: api/ArrlSection/5
        [HttpDelete("{id}")]
        public async Task<ActionResult<ArrlSection>> DeleteArrlSection(int id)
        {
            var arrlSection = await _context.ArrlSection.FindAsync(id);
            if (arrlSection == null)
            {
                return NotFound();
            }

            _context.ArrlSection.Remove(arrlSection);
            await _context.SaveChangesAsync();

            return arrlSection;
        }

        private bool ArrlSectionExists(int id)
        {
            return _context.ArrlSection.Any(e => e.Id == id);
        }
    }
}
