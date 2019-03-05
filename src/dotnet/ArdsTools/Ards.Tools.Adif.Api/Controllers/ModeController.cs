using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using Ards.Tools.Domain.Adif.Adif.Models;

namespace Ards.Tools.Adif.Api.Controllers
{
    [Route("api/Mode")]
    [ApiController]
    public class ModeController : ControllerBase
    {
        private readonly AdifDomainContext _context;

        public ModeController(AdifDomainContext context)
        {
            _context = context;
        }

        // GET: api/Mode
        [HttpGet]
        public async Task<ActionResult<IEnumerable<Mode>>> GetMode()
        {
            return await _context.Mode.ToListAsync();
        }

        // GET: api/Mode/5
        [HttpGet("{id}")]
        public async Task<ActionResult<Mode>> GetMode(int id)
        {
            var mode = await _context.Mode.FindAsync(id);

            if (mode == null)
            {
                return NotFound();
            }

            return mode;
        }

        // PUT: api/Mode/5
        [HttpPut("{id}")]
        public async Task<IActionResult> PutMode(int id, Mode mode)
        {
            if (id != mode.Id)
            {
                return BadRequest();
            }

            _context.Entry(mode).State = EntityState.Modified;

            try
            {
                await _context.SaveChangesAsync();
            }
            catch (DbUpdateConcurrencyException)
            {
                if (!ModeExists(id))
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

        // POST: api/Mode
        [HttpPost]
        public async Task<ActionResult<Mode>> PostMode(Mode mode)
        {
            _context.Mode.Add(mode);
            await _context.SaveChangesAsync();

            return CreatedAtAction("GetMode", new { id = mode.Id }, mode);
        }

        // DELETE: api/Mode/5
        [HttpDelete("{id}")]
        public async Task<ActionResult<Mode>> DeleteMode(int id)
        {
            var mode = await _context.Mode.FindAsync(id);
            if (mode == null)
            {
                return NotFound();
            }

            _context.Mode.Remove(mode);
            await _context.SaveChangesAsync();

            return mode;
        }

        private bool ModeExists(int id)
        {
            return _context.Mode.Any(e => e.Id == id);
        }
    }
}
