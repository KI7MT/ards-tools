using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using Ards.NetCore.Adif.Domain.Models;

namespace Ards.NetCore.Adif.Api.Controllers
{
    [Route("api/Submode")]
    [ApiController]
    public class SubmodeController : ControllerBase
    {
        private readonly AdifContext _context;

        public SubmodeController(AdifContext context)
        {
            _context = context;
        }

        // GET: api/Submode
        [HttpGet]
        public async Task<ActionResult<IEnumerable<Submode>>> GetSubmode()
        {
            return await _context.Submode.ToListAsync();
        }

        // GET: api/Submode/5
        [HttpGet("{id}")]
        public async Task<ActionResult<Submode>> GetSubmode(int id)
        {
            var submode = await _context.Submode.FindAsync(id);

            if (submode == null)
            {
                return NotFound();
            }

            return submode;
        }

        // PUT: api/Submode/5
        [HttpPut("{id}")]
        public async Task<IActionResult> PutSubmode(int id, Submode submode)
        {
            if (id != submode.Id)
            {
                return BadRequest();
            }

            _context.Entry(submode).State = EntityState.Modified;

            try
            {
                await _context.SaveChangesAsync();
            }
            catch (DbUpdateConcurrencyException)
            {
                if (!SubmodeExists(id))
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

        // POST: api/Submode
        [HttpPost]
        public async Task<ActionResult<Submode>> PostSubmode(Submode submode)
        {
            _context.Submode.Add(submode);
            await _context.SaveChangesAsync();

            return CreatedAtAction("GetSubmode", new { id = submode.Id }, submode);
        }

        // DELETE: api/Submode/5
        [HttpDelete("{id}")]
        public async Task<ActionResult<Submode>> DeleteSubmode(int id)
        {
            var submode = await _context.Submode.FindAsync(id);
            if (submode == null)
            {
                return NotFound();
            }

            _context.Submode.Remove(submode);
            await _context.SaveChangesAsync();

            return submode;
        }

        private bool SubmodeExists(int id)
        {
            return _context.Submode.Any(e => e.Id == id);
        }
    }
}
