
snpcal: snppic.f90 snpcal.f
	$(FC) -g $^ -o $@

clean:
	$(RM) snpcal *.o

test:
	@./snpcal 2018 7 | diff --text -a - ref/test.log
	@echo OK
