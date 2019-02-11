using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using Ards.NetCore.Adif.Domain.Models;

namespace Ards.NetCore.Adif.Api.Controllers
{
    [Route("api/Pas")]
    [ApiController]
    public class PasController : ControllerBase
    {
        private readonly AdifContext _context;

        public PasController(AdifContext context)
        {
            _context = context;
        }

        // GET: api/Pas
        [HttpGet]
        public async Task<ActionResult<IEnumerable<Pas>>> GetPas()
        {
            return await _context.Pas.ToListAsync();
        }

        // GET: api/Pas/5
        [HttpGet("{id}")]
        public async Task<ActionResult<Pas>> GetPas(int id)
        {
            var pas = await _context.Pas.FindAsync(id);

            if (pas == null)
            {
                return NotFound();
            }

            return pas;
        }

        // PUT: api/Pas/5
        [HttpPut("{id}")]
        public async Task<IActionResult> PutPas(int id, Pas pas)
        {
            if (id != pas.Id)
            {
                return BadRequest();
            }

            _context.Entry(pas).State = EntityState.Modified;

            try
            {
                await _context.SaveChangesAsync();
            }
            catch (DbUpdateConcurrencyException)
            {
                if (!PasExists(id))
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

        // POST: api/Pas
        [HttpPost]
        public async Task<ActionResult<Pas>> PostPas(Pas pas)
        {
            _context.Pas.Add(pas);
            await _context.SaveChangesAsync();

            return CreatedAtAction("GetPas", new { id = pas.Id }, pas);
        }

        // DELETE: api/Pas/5
        [HttpDelete("{id}")]
        public async Task<ActionResult<Pas>> DeletePas(int id)
        {
            var pas = await _context.Pas.FindAsync(id);
            if (pas == null)
            {
                return NotFound();
            }

            _context.Pas.Remove(pas);
            await _context.SaveChangesAsync();

            return pas;
        }

        private bool PasExists(int id)
        {
            return _context.Pas.Any(e => e.Id == id);
        }
    }
}
