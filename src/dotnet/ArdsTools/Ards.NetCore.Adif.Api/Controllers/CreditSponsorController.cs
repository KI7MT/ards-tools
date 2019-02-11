using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using Ards.NetCore.Adif.Domain.Models;

namespace Ards.NetCore.Adif.Api.Controllers
{
    [Route("api/CreditSponsor")]
    [ApiController]
    public class CreditSponsorController : ControllerBase
    {
        private readonly AdifContext _context;

        public CreditSponsorController(AdifContext context)
        {
            _context = context;
        }

        // GET: api/CreditSponsor
        [HttpGet]
        public async Task<ActionResult<IEnumerable<CreditSponsor>>> GetCreditSponsor()
        {
            return await _context.CreditSponsor.ToListAsync();
        }

        // GET: api/CreditSponsor/5
        [HttpGet("{id}")]
        public async Task<ActionResult<CreditSponsor>> GetCreditSponsor(int id)
        {
            var creditSponsor = await _context.CreditSponsor.FindAsync(id);

            if (creditSponsor == null)
            {
                return NotFound();
            }

            return creditSponsor;
        }

        // PUT: api/CreditSponsor/5
        [HttpPut("{id}")]
        public async Task<IActionResult> PutCreditSponsor(int id, CreditSponsor creditSponsor)
        {
            if (id != creditSponsor.Id)
            {
                return BadRequest();
            }

            _context.Entry(creditSponsor).State = EntityState.Modified;

            try
            {
                await _context.SaveChangesAsync();
            }
            catch (DbUpdateConcurrencyException)
            {
                if (!CreditSponsorExists(id))
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

        // POST: api/CreditSponsor
        [HttpPost]
        public async Task<ActionResult<CreditSponsor>> PostCreditSponsor(CreditSponsor creditSponsor)
        {
            _context.CreditSponsor.Add(creditSponsor);
            await _context.SaveChangesAsync();

            return CreatedAtAction("GetCreditSponsor", new { id = creditSponsor.Id }, creditSponsor);
        }

        // DELETE: api/CreditSponsor/5
        [HttpDelete("{id}")]
        public async Task<ActionResult<CreditSponsor>> DeleteCreditSponsor(int id)
        {
            var creditSponsor = await _context.CreditSponsor.FindAsync(id);
            if (creditSponsor == null)
            {
                return NotFound();
            }

            _context.CreditSponsor.Remove(creditSponsor);
            await _context.SaveChangesAsync();

            return creditSponsor;
        }

        private bool CreditSponsorExists(int id)
        {
            return _context.CreditSponsor.Any(e => e.Id == id);
        }
    }
}
