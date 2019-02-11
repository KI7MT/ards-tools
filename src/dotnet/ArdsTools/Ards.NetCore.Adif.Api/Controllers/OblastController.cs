using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using Ards.NetCore.Adif.Domain.Models;

namespace Ards.NetCore.Adif.Api.Controllers
{
    [Route("api/Oblast")]
    [ApiController]
    public class OblastController : ControllerBase
    {
        private readonly AdifContext _context;

        public OblastController(AdifContext context)
        {
            _context = context;
        }

        // GET: api/Oblast
        [HttpGet]
        public async Task<ActionResult<IEnumerable<Oblast>>> GetOblast()
        {
            return await _context.Oblast.ToListAsync();
        }

        // GET: api/Oblast/5
        [HttpGet("{id}")]
        public async Task<ActionResult<Oblast>> GetOblast(int id)
        {
            var oblast = await _context.Oblast.FindAsync(id);

            if (oblast == null)
            {
                return NotFound();
            }

            return oblast;
        }

        // PUT: api/Oblast/5
        [HttpPut("{id}")]
        public async Task<IActionResult> PutOblast(int id, Oblast oblast)
        {
            if (id != oblast.Id)
            {
                return BadRequest();
            }

            _context.Entry(oblast).State = EntityState.Modified;

            try
            {
                await _context.SaveChangesAsync();
            }
            catch (DbUpdateConcurrencyException)
            {
                if (!OblastExists(id))
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

        // POST: api/Oblast
        [HttpPost]
        public async Task<ActionResult<Oblast>> PostOblast(Oblast oblast)
        {
            _context.Oblast.Add(oblast);
            await _context.SaveChangesAsync();

            return CreatedAtAction("GetOblast", new { id = oblast.Id }, oblast);
        }

        // DELETE: api/Oblast/5
        [HttpDelete("{id}")]
        public async Task<ActionResult<Oblast>> DeleteOblast(int id)
        {
            var oblast = await _context.Oblast.FindAsync(id);
            if (oblast == null)
            {
                return NotFound();
            }

            _context.Oblast.Remove(oblast);
            await _context.SaveChangesAsync();

            return oblast;
        }

        private bool OblastExists(int id)
        {
            return _context.Oblast.Any(e => e.Id == id);
        }
    }
}
