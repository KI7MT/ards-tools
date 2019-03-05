using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using Ards.Tools.Domain.Adif.Adif.Models;

namespace Ards.Tools.Adif.Api.Controllers
{
    [Route("api/CreditAward")]
    [ApiController]
    public class CreditAwardController : ControllerBase
    {
        private readonly AdifDomainContext _context;

        public CreditAwardController(AdifDomainContext context)
        {
            _context = context;
        }

        // GET: api/CreditAward
        [HttpGet]
        public async Task<ActionResult<IEnumerable<CreditAward>>> GetCreditAward()
        {
            return await _context.CreditAward.ToListAsync();
        }

        // GET: api/CreditAward/5
        [HttpGet("{id}")]
        public async Task<ActionResult<CreditAward>> GetCreditAward(int id)
        {
            var creditAward = await _context.CreditAward.FindAsync(id);

            if (creditAward == null)
            {
                return NotFound();
            }

            return creditAward;
        }

        // PUT: api/CreditAward/5
        [HttpPut("{id}")]
        public async Task<IActionResult> PutCreditAward(int id, CreditAward creditAward)
        {
            if (id != creditAward.Id)
            {
                return BadRequest();
            }

            _context.Entry(creditAward).State = EntityState.Modified;

            try
            {
                await _context.SaveChangesAsync();
            }
            catch (DbUpdateConcurrencyException)
            {
                if (!CreditAwardExists(id))
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

        // POST: api/CreditAward
        [HttpPost]
        public async Task<ActionResult<CreditAward>> PostCreditAward(CreditAward creditAward)
        {
            _context.CreditAward.Add(creditAward);
            await _context.SaveChangesAsync();

            return CreatedAtAction("GetCreditAward", new { id = creditAward.Id }, creditAward);
        }

        // DELETE: api/CreditAward/5
        [HttpDelete("{id}")]
        public async Task<ActionResult<CreditAward>> DeleteCreditAward(int id)
        {
            var creditAward = await _context.CreditAward.FindAsync(id);
            if (creditAward == null)
            {
                return NotFound();
            }

            _context.CreditAward.Remove(creditAward);
            await _context.SaveChangesAsync();

            return creditAward;
        }

        private bool CreditAwardExists(int id)
        {
            return _context.CreditAward.Any(e => e.Id == id);
        }
    }
}
