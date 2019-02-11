using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using Ards.NetCore.Adif.Domain.Models;

namespace Ards.NetCore.Adif.Api.Controllers
{
    [Route("api/Sas")]
    [ApiController]
    public class SasController : ControllerBase
    {
        private readonly AdifContext _context;

        public SasController(AdifContext context)
        {
            _context = context;
        }

        // GET: api/Sas
        [HttpGet]
        public async Task<ActionResult<IEnumerable<Sas>>> GetSas()
        {
            return await _context.Sas.ToListAsync();
        }

        // GET: api/Sas/5
        [HttpGet("{id}")]
        public async Task<ActionResult<Sas>> GetSas(int id)
        {
            var sas = await _context.Sas.FindAsync(id);

            if (sas == null)
            {
                return NotFound();
            }

            return sas;
        }

        // PUT: api/Sas/5
        [HttpPut("{id}")]
        public async Task<IActionResult> PutSas(int id, Sas sas)
        {
            if (id != sas.Id)
            {
                return BadRequest();
            }

            _context.Entry(sas).State = EntityState.Modified;

            try
            {
                await _context.SaveChangesAsync();
            }
            catch (DbUpdateConcurrencyException)
            {
                if (!SasExists(id))
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

        // POST: api/Sas
        [HttpPost]
        public async Task<ActionResult<Sas>> PostSas(Sas sas)
        {
            _context.Sas.Add(sas);
            await _context.SaveChangesAsync();

            return CreatedAtAction("GetSas", new { id = sas.Id }, sas);
        }

        // DELETE: api/Sas/5
        [HttpDelete("{id}")]
        public async Task<ActionResult<Sas>> DeleteSas(int id)
        {
            var sas = await _context.Sas.FindAsync(id);
            if (sas == null)
            {
                return NotFound();
            }

            _context.Sas.Remove(sas);
            await _context.SaveChangesAsync();

            return sas;
        }

        private bool SasExists(int id)
        {
            return _context.Sas.Any(e => e.Id == id);
        }
    }
}
